//
//  ViewController.swift
//  CALayer
//
//  Created by Admin on 22/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 20 //ширина линии
            shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round") //траектория считается замкнутой
            shapeLayer.fillColor = nil //чтоб фигура не заполнялась черным цветом
            shapeLayer.strokeEnd = 1 //
            let color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 20 //ширина линии
            overShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round") //траектория считается замкнутой
            overShapeLayer.fillColor = nil //чтоб фигура не заполнялась черным цветом
            overShapeLayer.strokeEnd = 0 //
            let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overShapeLayer.strokeColor = color
        }
    }
    
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 1, green: 0.8370772162, blue: 0.9749883552, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
            //gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.blue.cgColor]
            //gradientLayer.locations = [0, 0.2, 1]  //распределения цвета по градиенту
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            //imageView.layer.cornerRadius = 30 //закругление углов картинки
            imageView.layer.cornerRadius = imageView.frame.size.height / 2 //закругление углов картинки до круга
            imageView.layer.masksToBounds = true //применение закругления, когда картинка выходит за рамки image View
            let borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)  //цвет рамки вокруг картинки
            imageView.layer.borderColor = borderColor.cgColor //присвоение рамке цвета
            imageView.layer.borderWidth = 9 //ширина рамки
            
        }
    }
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.shadowOffset = CGSize(width: 0, height: 5) //смещение тени
            button.layer.shadowOpacity = 0.5 //непрозрачность тени
            button.layer.shadowRadius = 5 //рассеяность тени
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
       
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer){
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        shapeLayer.path = path.cgPath
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer) //добавление на вью
        
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
    }


    @IBAction func tapped(_ sender: UIButton) {
        overShapeLayer.strokeEnd += 0.2
        if overShapeLayer.strokeEnd == 1 {
            performSegue(withIdentifier: "showSecondScreen", sender: self)
        }
    }
}

