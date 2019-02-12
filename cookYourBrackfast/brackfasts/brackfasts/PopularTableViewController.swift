//
//  PopularTableViewController.swift
//  brackfasts
//
//  Created by Admin on 11/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CloudKit

class PopularTableViewController: UITableViewController {
    
    
    var brackfasts: [CKRecord] = []
    var spinner: UIActivityIndicatorView!
    var cache = NSCache<CKRecord.ID, AnyObject>()
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        refreshControl?.addTarget(self, action: #selector(getCloudRecords), for: .valueChanged)
        
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.addSubview(spinner)
        //
        //        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        //        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: tableView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: tableView, attribute: .centerY, multiplier: 0.85, constant: 0).isActive = true
        
        
        getCloudRecords()
    }
    
    @objc func getCloudRecords(){
        brackfasts = []
        //
        //        let predicate = NSPredicate(value: true)
        //        let query = CKQuery(recordType: "Brackfast", predicate: predicate)
        //        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
        //            guard error == nil else { print(error!)
        //                return
        //
        //            }
        //            if let records = records {
        //                self.brackfasts = records
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //        }
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Brackfast", predicate: predicate)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        
        query.sortDescriptors = [sort]
        
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name"]
        queryOperation.resultsLimit = 10
        queryOperation.queuePriority = .veryHigh
        queryOperation.recordFetchedBlock = { (record: CKRecord!) in
            if let record = record{
                self.brackfasts.append(record)
            }
        }
        queryOperation.queryCompletionBlock = { (cursor, error) in
            guard error == nil else {
                print("ne ydalos polychit zapisi \(error!.localizedDescription)" )
                return
            }
            print("vse ok")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                self.refreshControl?.endRefreshing()
            }
        }
        publicDataBase.add(queryOperation)
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return brackfasts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let brackfast = brackfasts[indexPath.row]
        cell.textLabel?.text = brackfast.object(forKey: "name") as? String
        cell.imageView?.image = UIImage(named: "photo")
        
        if let imageURL = cache.object(forKey: brackfast.recordID) as? URL {
            if let data = try? Data(contentsOf: imageURL) {
                cell.imageView?.image = UIImage(data: data)
            }
        } else {
            
        let fetchRecordsOperation = CKFetchRecordsOperation(recordIDs: [brackfast.recordID])
        fetchRecordsOperation.desiredKeys = ["image"]
        fetchRecordsOperation.queuePriority = .veryHigh
        
        fetchRecordsOperation.perRecordCompletionBlock = {
            (record, recordID, error) in
            
            guard error == nil else {
                print("ne ydalos zagryzit izobrazhenie")
                return
            }
            
            guard let record = record else { return }
            guard let image = record.object(forKey: "image") else { return }
            let imageAsset = image as! CKAsset
                    
            guard let data = try? Data(contentsOf: imageAsset.fileURL) else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data)
                self.cache.setObject(imageAsset.fileURL as AnyObject, forKey: brackfast.recordID)
            }
        }
        publicDataBase.add(fetchRecordsOperation)
    }
    return cell
}


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
