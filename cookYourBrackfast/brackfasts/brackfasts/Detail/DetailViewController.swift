//
//  DetailViewController.swift
//  brackfasts
//
//  Created by Admin on 25/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var breakfast: Bracfast?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIButton!
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard  let svc = segue.source as? RateViewController else { return }
        guard let rating = svc.breakfRating else { return }
        rateButton.setImage(UIImage(named: rating), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden((false), animated: true)
    }
        
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [rateButton, mapButton]
        for button in buttons {
            guard let button = button else {break}
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableView.automaticDimension
        
        imageView.image = UIImage(data: breakfast!.image! as Data)

//        tableView.backgroundColor = #colorLiteral(red: 0.6691333746, green: 0.9568627477, blue: 0.8621997098, alpha: 1)
//        tableView.separatorColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = breakfast!.name
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
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue"{
            let dvc = segue.destination as! MapViewController
        dvc.breakfast = self.breakfast
    }
}
    
    
    
    
}
