//
//  DetailVC.swift
//  myMusic
//
//  Created by Admin on 20/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var treckTitle = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: treckTitle)
        titleLabel.text = treckTitle
        titleLabel.numberOfLines = 0
    }
}
