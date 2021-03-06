//
//  breakfastsTableViewController.swift
//  breakfasts
//
//  Created by Admin on 23/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class BreakfastsTableViewController: UITableViewController {

    var breakfasts: [breakfast] = [
        breakfast(name: "1", type: "egg", location: "Moscow", image: "1.jpg", isVisited: false),
        breakfast(name: "2", type: "egg", location: "New York", image: "2.jpg", isVisited: false),
        breakfast(name: "3", type: "egg", location: "Kiev", image: "3.jpg", isVisited: false),
        breakfast(name: "4", type: "egg", location: "sdkljflskdjf", image: "4.jpg", isVisited: false),
        breakfast(name: "5", type: "egg", location: "sdkljflskdjf", image: "5.jpg", isVisited: false),
        breakfast(name: "6", type: "egg", location: "sdkljflskdjf", image: "6.jpg", isVisited: false),
        breakfast(name: "7", type: "egg", location: "sdkljflskdjf", image: "7.jpg", isVisited: false),
        breakfast(name: "8", type: "egg", location: "sdkljflskdjf", image: "8.jpeg", isVisited: false),
        breakfast(name: "9", type: "egg", location: "sdkljflskdjf", image: "9.jpg", isVisited: false),
        breakfast(name: "10", type: "egg", location: "sdkljflskdjf", image: "10.jpg", isVisited: false),
        breakfast(name: "11", type: "egg", location: "sdkljflskdjf", image: "11.jpg", isVisited: false),
        breakfast(name: "12", type: "egg", location: "sdkljflskdjf", image: "12.jpg", isVisited: false),
        breakfast(name: "13", type: "egg", location: "sdkljflskdjf", image: "13.jpg", isVisited: false),
        breakfast(name: "14", type: "egg", location: "sdkljflskdjf", image: "14.jpg", isVisited: false),
        breakfast(name: "15", type: "egg", location: "sdkljflskdjf", image: "15.jpg", isVisited: false)]
    
    @IBAction func close(segue: UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakfasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BreakfastsTableViewCell

        cell.thumbnailImageView.image = UIImage(named: breakfasts[indexPath.row].image)
        cell.thumbnailImageView.layer.cornerRadius = 32.5 //делаем изображение круглым
        cell.thumbnailImageView.clipsToBounds = true //применяем обрезку изображений
        cell.nameLabel.text = breakfasts[indexPath.row].name
        cell.locationLabel.text = breakfasts[indexPath.row].location
        cell.typeLabel.text = breakfasts[indexPath.row].type

        
        cell.accessoryType = self.breakfasts[indexPath.row].isVisited ? .checkmark : .none // не дублируем галочки
        
        return cell
    
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let ac = UIAlertController(title: nil, message: "Рецепт", preferredStyle: .actionSheet)
//        let call = UIAlertAction(title: "Resepric\(indexPath.row)", style: .default){
//            (action: UIAlertAction) -> Void in
//
//            let alertC = UIAlertController(title: nil, message: "No recepts", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertC.addAction(ok)
//            self.present(alertC, animated: true, completion: nil)
//        }
//        let isVisitedTitle = self.breakfastVisit[indexPath.row] ? "im not cook it" : "i cook it"
//        let isVisited = UIAlertAction(title: isVisitedTitle, style: .default)
//        { (action) in
//            let cell = tableView.cellForRow(at: indexPath)
//
//            self.breakfastVisit[indexPath.row] = !self.breakfastVisit[indexPath.row]
//            cell?.accessoryType = self.breakfastVisit[indexPath.row] ? .checkmark : .none
//        }
//
//        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//
//        ac.addAction(isVisited)
//        ac.addAction(cancel)
//        ac.addAction(call)
//        present(ac, animated: true, completion: nil)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            self.breakfastsArrayImage.remove(at: indexPath.row)
//            self.breakfastsArrayName.remove(at: indexPath.row)
//            self.breakfastVisit.remove(at: indexPath.row)
//        }
//    //    tableView.reloadData()
//    tableView.deleteRows(at: [indexPath], with: .fade) // animation for deliting
//
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") {(action, indexPath) in
            let defaultText = "I am here now" + self.breakfasts[indexPath.row].name
            if let image = UIImage(named: self.breakfasts[indexPath.row].image){
                let activiryController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
self.present(activiryController, animated: true, completion: nil)
            }
    }
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, indexPath) in
            self.breakfasts.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade) // animation for deliting
        }
        share.backgroundColor = #colorLiteral(red: 0, green: 0.6837591477, blue: 1, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return[delete, share]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! DetailViewController
                dvc.breakfast = self.breakfasts[indexPath.row]
            }
        }
    }
}
