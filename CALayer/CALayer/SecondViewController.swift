//
//  SecondViewController.swift
//  CALayer
//
//  Created by Admin on 22/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate  {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 10 //ширина линии
            shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round") //траектория считается замкнутой
            shapeLayer.fillColor = nil //чтоб фигура не заполнялась черным цветом
            shapeLayer.strokeEnd = 1 //
            let color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 10 //ширина линии
            overShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round") //траектория считается замкнутой
            overShapeLayer.fillColor = nil //чтоб фигура не заполнялась черным цветом
            overShapeLayer.strokeEnd = 0 //
            let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overShapeLayer.strokeColor = color
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            let startColor = #colorLiteral(red: 1, green: 0.8370772162, blue: 0.9749883552, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
            //gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.blue.cgColor]
            gradientLayer.locations = [0.2, 0.8]  //распределения цвета по градиенту
        }
    }

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
//            imageView.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
//            imageView.layer.borderWidth = 7
        }
    }
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.shadowOffset = CGSize(width: 2, height: 5)
            button.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            button.layer.shadowRadius = 1
            button.layer.shadowOpacity = 0.5
        }
        
    }

    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer){
        shapeLayer.frame = view.bounds
        let path = UIBezierPath(arcCenter: imageView.center, radius: imageView.frame.size.height / 2, startAngle: 1, endAngle: 7.5, clockwise: true)
        path.addArc(withCenter: imageView.center, radius: imageView.frame.size.height / 2, startAngle: 1, endAngle: 7.5, clockwise: true)
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
        let animation = CABasicAnimation(keyPath: "strokeEnd") //свойство
        animation.toValue = 1 //значение конечное
        animation.duration = 2 // длительность анимации
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut) //для обозначения как должна проходить анимация
        animation.fillMode = CAMediaTimingFillMode.both //чтоб анимацмя не удалялась по завершению
        animation.isRemovedOnCompletion = false //удаляется по завершению если тру
        
        animation.delegate = self // для реализации метода
        
        overShapeLayer.add(animation, forKey: nil) // добавление анимации
        
        //        overShapeLayer.strokeEnd += 0.2
        //        if overShapeLayer.strokeEnd == 1 {
        //            performSegue(withIdentifier: "showSecondScreen", sender: self)
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("The end")
        
    }
    
    
}
