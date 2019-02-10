//
//  ContentViewController.swift
//  brackfasts
//
//  Created by Admin on 09/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var pageButton: UIButton!
    
    @IBAction func pageButoonPressed(_ sender: UIButton) {
        switch index {
        case 0:
            let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "wasIntroWatched")
            userDefaults.synchronize()
            
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageButton.layer.cornerRadius = 15
        pageButton.clipsToBounds = true
        pageButton.layer.borderWidth = 2
        pageButton.backgroundColor = #colorLiteral(red: 0.9286971092, green: 0.7960545985, blue: 0.9220232494, alpha: 1)
        pageButton.layer.borderColor = (#colorLiteral(red: 0.9286971092, green: 0.7960545985, blue: 0.9220232494, alpha: 1)).cgColor
        
        switch index {
        case 0: pageButton.setTitle("Next", for: .normal)
        case 1: pageButton.setTitle("Open", for: .normal)
        default:
            break
        }
        
        headerLabel.text = header
        subheaderLabel.text = subheader
        imageView.image = UIImage(named: imageFile)
        pageControll.numberOfPages = 2
        pageControll.currentPage = index
        
    }
    

}
