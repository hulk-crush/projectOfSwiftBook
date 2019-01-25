//
//  DetailViewController.swift
//  brackfasts
//
//  Created by Admin on 25/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imageName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
