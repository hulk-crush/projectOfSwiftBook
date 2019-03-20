//
//  Background.swift
//  WarFly
//
//  Created by Admin on 20/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {

    static func populateBackgraund(at point: CGPoint) -> Background{
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
        
    }
    
}
