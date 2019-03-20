//
//  GameScene.swift
//  GameDemo
//
//  Created by Admin on 20/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   
    override func didMove(to view: SKView) {
        
        let sprite = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        self.addChild(sprite)
        
    }
    
}
