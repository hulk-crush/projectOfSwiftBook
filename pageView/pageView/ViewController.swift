//
//  ViewController.swift
//  pageView
//
//  Created by Admin on 21/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    
    func startPresentation()  {
        let userDefaults = UserDefaults.standard
        let presentatioinWasViewed = userDefaults.bool(forKey: ("presentationWasViewed"))
        if presentatioinWasViewed == false{
            if let pageViewController = storyboard?.instantiateViewController(
                withIdentifier: "PageViewController") as? PageViewController{
                
                present(pageViewController, animated: true, completion: nil)
            }
        }
    }
}

