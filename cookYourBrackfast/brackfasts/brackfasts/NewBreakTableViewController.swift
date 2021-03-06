//
//  NewBreakTableViewController.swift
//  brackfasts
//
//  Created by Admin on 05/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CloudKit

class NewBreakTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var isVisited = false
    
    
    @IBAction func toggleIsVisitegPressed(_ sender: UIButton) {
        if sender == yesButton{
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            isVisited = true
        } else {
        sender.backgroundColor = #colorLiteral(red: 1, green: 0.1035235793, blue: 0.07981744581, alpha: 1)
        yesButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        isVisited = false
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || addressTextField.text == "" || typeTextField.text == ""{
            print("not all string full")
        } else{
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
                let bracfast = Bracfast(context: context)
                bracfast.name = nameTextField.text
                bracfast.location = addressTextField.text
                bracfast.type = typeTextField.text
                bracfast.isVisited = isVisited
                if let image = imageView.image{
                    bracfast.image = image.pngData()
                }
                do{
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
                saveToCloud(bracfast)
            }
            performSegue(withIdentifier: "unwindSegueFromBr", sender: self)
        }
        
    }
    
    
    func saveToCloud(_ brackfast: Bracfast){
        
        let bracRecord = CKRecord(recordType: "Bracfast")
        bracRecord.setValue(nameTextField.text, forKey: "name")
        bracRecord.setValue(typeTextField.text, forKey: "type" )
        bracRecord.setValue(addressTextField.text, forKey: "location")
        
        guard let originImage = UIImage(data: brackfast.image! as Data) else { return }
        let scale = originImage.size.width > 1080.0 ? 1080.0 / originImage.size.width : 1.0
        let scaledImage = UIImage(data: brackfast.image! as Data, scale: scale)
        
        let imageFilePath = NSTemporaryDirectory() + brackfast.name!
        let imageFileURL = URL(fileURLWithPath: imageFilePath)
        
        do {
            try scaledImage?.jpegData(compressionQuality: 0.7)?.write(to: imageFileURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
        
        let imageAsset = CKAsset(fileURL: imageFileURL)
        bracRecord.setValue(imageAsset, forKey: "image")
        let publicDataBase = CKContainer.default().publicCloudDatabase
        publicDataBase.save(bracRecord) { (record, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            do {
                try FileManager.default.removeItem(at: imageFileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noButton.backgroundColor = #colorLiteral(red: 1, green: 0.1035235793, blue: 0.07981744581, alpha: 1)
        yesButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let alertController = UIAlertController(title: NSLocalizedString("photo", comment: "photo"), message: nil, preferredStyle: .actionSheet)
        
            let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera") , style: .default) { (action) in
                self.chooseImagePickerAction(source: .camera)
            }
            let photoLibAction = UIAlertAction(title: NSLocalizedString("Library", comment: "Library"), style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
            alertController.addAction(cameraAction)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
