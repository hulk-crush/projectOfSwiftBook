//
//  BrackfastsTableViewController.swift
//  brackfasts
//
//  Created by Admin on 23/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import  CoreData

class BrackfastsTableViewController: UITableViewController {
    
    var fetchResultsController: NSFetchedResultsController<Bracfast>!
    var searchController: UISearchController!
    var filtredResultArray: [Bracfast] = []
    var brackfasts: [Bracfast] = []
    
    
//        Bracfast(name: "1", type: "egg", location: "Moscow", image: "1.jpg", isVisited: false),
//        Bracfast(name: "2", type: "egg", location: "New York", image: "2.jpg", isVisited: false),
//        Bracfast(name: "3", type: "egg", location: "Kiev", image: "3.jpg", isVisited: false),
//        Bracfast(name: "4", type: "egg", location: "sdkljflskdjf", image: "4.jpg", isVisited: false),
//        Bracfast(name: "5", type: "egg", location: "sdkljflskdjf", image: "5.jpg", isVisited: false),
//        Bracfast(name: "6", type: "egg", location: "sdkljflskdjf", image: "6.jpg", isVisited: false),
//        Bracfast(name: "7", type: "egg", location: "sdkljflskdjf", image: "7.jpg", isVisited: false),
//        Bracfast(name: "8", type: "egg", location: "sdkljflskdjf", image: "8.jpeg", isVisited: false),
//        Bracfast(name: "9", type: "egg", location: "sdkljflskdjf", image: "9.jpg", isVisited: false),
//        Bracfast(name: "10", type: "egg", location: "sdkljflskdjf", image: "10.jpg", isVisited: false),
//        Bracfast(name: "11", type: "egg", location: "sdkljflskdjf", image: "11.jpg", isVisited: false),
//        Bracfast(name: "12", type: "egg", location: "sdkljflskdjf", image: "12.jpg", isVisited: false),
//        Bracfast(name: "13", type: "egg", location: "sdkljflskdjf", image: "13.jpg", isVisited: false),
//        Bracfast(name: "14", type: "egg", location: "sdkljflskdjf", image: "14.jpg", isVisited: false),
//        Bracfast(name: "15", type: "egg", location: "sdkljflskdjf", image: "15.jpg", isVisited: false)]
    
    @IBAction func close(segue: UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func filterContentFor(searchText text: String){
        filtredResultArray = brackfasts.filter{(brackfast) -> Bool in
            return(brackfast.name?.lowercased().contains(text.lowercased()))! // сравнивание маленьких букв, приведение больших к маленьким и сравнивается с поисковым запросом
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        
        let fetchRequest: NSFetchRequest<Bracfast> = Bracfast.fetchRequest() //фильтр
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true) //сортировка по имени
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) //read about it
        
            do {
                try fetchResultsController.performFetch()
                brackfasts = fetchResultsController.fetchedObjects!
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        
        
        }
    }
    
    //   MARK: - Fetch results controller delegate
    func  controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else {break}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        brackfasts = controller.fetchedObjects as! [Bracfast]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult> ) {
        tableView.endUpdates()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackfasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BrackfastsTableViewCell

        cell.thumbnailImageView.image = UIImage(data: brackfasts[indexPath.row].image! as Data)
        cell.thumbnailImageView.layer.cornerRadius = 32.5 //делаем изображение круглым
        cell.thumbnailImageView.clipsToBounds = true //применяем обрезку изображений
        cell.nameLabel.text = brackfasts[indexPath.row].name
        cell.locationLabel.text = brackfasts[indexPath.row].location
        cell.typeLabel.text = brackfasts[indexPath.row].type

        
        cell.accessoryType = self.brackfasts[indexPath.row].isVisited ? .checkmark : .none // не дублируем галочки
        
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
//        let isVisitedTitle = self.bracfastVisit[indexPath.row] ? "im not cook it" : "i cook it"
//        let isVisited = UIAlertAction(title: isVisitedTitle, style: .default)
//        { (action) in
//            let cell = tableView.cellForRow(at: indexPath)
//
//            self.bracfastVisit[indexPath.row] = !self.bracfastVisit[indexPath.row]
//            cell?.accessoryType = self.bracfastVisit[indexPath.row] ? .checkmark : .none
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
//            self.bracfastsArrayImage.remove(at: indexPath.row)
//            self.bracfastsArrayName.remove(at: indexPath.row)
//            self.bracfastVisit.remove(at: indexPath.row)
//        }
//    //    tableView.reloadData()
//    tableView.deleteRows(at: [indexPath], with: .fade) // animation for deliting
//
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") {(action, indexPath) in
            let defaultText = "I am here now" + self.brackfasts[indexPath.row].name!
            if let image = UIImage(data: self.brackfasts[indexPath.row].image! as Data){
                let activiryController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
self.present(activiryController, animated: true, completion: nil)
                
            }
    }
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, indexPath) in
            self.brackfasts.remove(at: indexPath.row)
            
          //  tableView.deleteRows(at: [indexPath], with: .fade) // animation for deliting
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
            let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                    
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
        share.backgroundColor = #colorLiteral(red: 0, green: 0.6837591477, blue: 1, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return[delete, share]
        
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! DetailViewController
                dvc.breakfast = self.brackfasts[indexPath.row]
            }
        }
    }
}

extension BrackfastsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}
