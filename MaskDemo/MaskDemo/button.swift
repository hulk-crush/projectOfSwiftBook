//
//  button.swift
//  MaskDemo
//
//  Created by Admin on 25/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit


@IBDesignable
class Button: UIButton {
    
    private var cornerRadi = CGSize()
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            cornerRadi = CGSize(width: cornerRadius, height: cornerRadius)
        }
    }
    
    @IBInspectable var color: UIColor = .blue
    
    var path: UIBezierPath?
    
    override func draw(_ rect: CGRect){
        super.draw(rect)
    
        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: cornerRadi)
        color.setFill()
        path?.fill()
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let path = path {
            return path.contains(point)
        }
        return false
    }
}
