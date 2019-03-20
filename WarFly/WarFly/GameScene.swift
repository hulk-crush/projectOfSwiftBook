//
//  GameScene.swift
//  WarFly
//
//  Created by Admin on 20/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackgraund(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        
        let screen = UIScreen.main.bounds //размер экрана пользователя
        for _ in 1...7 {
            
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))

            let island = Island.populateIsland(at: CGPoint(x: x, y: y))
            self.addChild(island)
        }
    }
}
