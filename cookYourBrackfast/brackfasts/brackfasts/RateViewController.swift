//
//  RateViewController.swift
//  brackfasts
//
//  Created by Admin on 30/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var sosoButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    var breakfRating: String?
    
    @IBAction func rateBreakfast (sender: UIButton){
        switch  sender.tag {
        case 0: breakfRating = "bad"
        case 1: breakfRating = "Soso"
        case 2: breakfRating = "good"
        default: break
        }
        performSegue(withIdentifier: "unvindSegueToDVC", sender: sender)
    }
        
        
        
        
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.4){
//            self.ratingStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
let buttonArray = [badButton, sosoButton, goodButton]
        for (index, button) in buttonArray.enumerated(){
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {button?.transform = CGAffineTransform(scaleX: 1, y: 1)}, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        ratingStackView.transform = CGAffineTransform(scaleX: 0, y: 0)

        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        sosoButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.view.insertSubview(blurView, at: 1)
    
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
