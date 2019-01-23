//
//  SecondViewController.swift
//  PassDataProgect
//
//  Created by Admin on 16/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var login: String!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "uwindSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let login = login else { return }
        label.text = "Hello, \(login)"
    }

}
