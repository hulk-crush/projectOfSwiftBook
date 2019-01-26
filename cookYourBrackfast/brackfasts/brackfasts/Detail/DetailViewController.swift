//
//  DetailViewController.swift
//  brackfasts
//
//  Created by Admin on 25/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var imageView: UIImageView!
    var breakfast: Bracfast?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: breakfast!.image)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
            BrDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = breakfast!.name
        case 1:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = breakfast!.type
        case 2:
            cell.keyLabel.text = "Adress"
            cell.valueLabel.text = breakfast!.location
        case 3:
            cell.keyLabel.text = "I been here"
            cell.valueLabel.text = breakfast!.isVisited ? "Yes" : "No"
        default:
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
