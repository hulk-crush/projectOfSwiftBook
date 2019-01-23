//
//  ViewController.swift
//  testing
//
//  Created by Admin on 18/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        textView.delegate = self
        
        textView.text = ""
        
        textView.isHidden = true
        textView.alpha = 0
        
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        textView.backgroundColor = self.view.backgroundColor
        
        textView.layer.cornerRadius = 10
        
        stepper.value = 17
        stepper.minimumValue = 10
        stepper.maximumValue = 25
        
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        stepper.layer.cornerRadius = 5
        
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0, delay: 3, options: .curveEaseIn, animations: {
            self.textView.alpha = 1
        }) {(finished) in
        self.activityIndicator.stopAnimating()
        self.textView.isHidden = false
    }
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    @IBAction func sizeFont(_ sender: UIStepper) {
        
        let font = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        
        textView.font = UIFont(name: font!, size: fontSize)
    }
}
//
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)),
//                                               name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)),
//                                               name: Notification.Name.UIKeyboardWillHide, object: nil)
//
    
//        textView.resignFirstResponder() скрывает клавиатуру под конкретный обьект
    
    
    
//    @objc func updateTextView(notification: Notification){
//        guard let userInfo = notification.userInfo as? [String: AnyObject],
//        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//        else {return}
//
//        if notification.name == Notification.Name.UIKeyboardWillHide{
//            textView.contentInset = UIEdgeInsets.zero
//        } else {
//                    textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//                    textView.scrollIndicatorInsets = textView.contentInset
//                    }
//                    textView.scrollRangeToVisible(textView.selectedRange)
//            }
//        }


//extension ViewController: UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView) { //при тапе на текст вью
//      textView.backgroundColor = .white
//        textView.textColor = .gray
//    }
//    func textViewDidEndEditing(_ textView: UITextView) { // при окончании работы с текст вью
//        textView.backgroundColor = self.view.backgroundColor
//        textView.textColor = .black
//    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        countLabel.text = "\(textView.text.count)"
//    return textView.text.count + (text.count - range.length) <= 60
//    }

