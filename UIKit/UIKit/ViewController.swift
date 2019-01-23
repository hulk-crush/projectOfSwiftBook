//
//  ViewController.swift
//  UIKit
//
//  Created by Admin on 18/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    var uiElements = ["UILabel",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker",
                      "UISlider"]
    
    var selesctElement : String?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.value = 1
        
        lable.text = String(slider.value)
        lable.font = lable.font.withSize(35)
        lable.textAlignment = .center
        lable.numberOfLines = 2
        
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue

        datePicker.locale = Locale(identifier: "ru_Ru")

        choiceElement(){

    }
        func hideAllElements() {
            lable.isHidden = true
            slider.isHidden = true
            button.isHidden = true
            datePicker.isHidden = true
        }

    func choiceElement(){
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
    
        textField.inputView = elementPicker
        elementPicker.backgroundColor = .brown
    }
        
        func createToolbar() {
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done",
                                             style: .plain,
                                             target: self,
                                             action: #selector(dismissKeyboard))
            
            toolbar.setItems([doneButton], animated: true)
            toolbar.isUserInteractionEnabled = true
            
            textField.inputAccessoryView = toolbar
            
            // Castomization
            toolbar.tintColor = .white
            toolbar.barTintColor = .brown
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
        @IBAction func sliderAction(_ sender: UISlider) {
            lable.text = String(sender.value)
            
            let backgrandColor = self.view.backgroundColor
            self.view.backgroundColor = backgrandColor?.withAlphaComponent(CGFloat(sender.value))
        }
        
        
        @IBAction func donePressed(_ sender: UIButton) {
            
            guard textField.text?.isEmpty == false else { return }
            
            if let _ = Double(textField.text!) {
                
                let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                print("Name format is wrong")
                
            } else {
                
                lable.text = textField.text
                textField.text = nil
            }
        }
        

        
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.locale = Locale(identifier: "ru_Ru")
        let dateValue = dateFormater.string(from: sender.date)
    
        lable.text = dateValue
    
    }
    
    @IBAction func button(_ sender: UIButton) {
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        datePicker.isHidden = !datePicker.isHidden
        lable.isHidden = !lable.isHidden
        textField.isHidden = !textField.isHidden
        button.isHidden = !button.isHidden

        if sender.isOn{
            switchLabel.text = "Отобразить элементы"
        } else{
            switchLabel.text = "Скрыть элементы"
        }
        
        
    }


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int , inComponent component: Int) {
        selesctElement = uiElements[row]
        textField.text = selesctElement
    }
}
}
