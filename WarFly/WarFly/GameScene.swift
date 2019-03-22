//
//  GameScene.swift
//  WarFly
//
//  Created by Admin on 20/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion //доступ к сенсорам телефона

class GameScene: SKScene {
    
    let motionManager = CMMotionManager() //доступ к акселерометру
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackgraund(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        
        let screen = UIScreen.main.bounds //размер экрана пользователя
        for _ in 1...7 {
            
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))

            let island = Island.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(island)
            
            let cloud = Cloud.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(cloud)
        }
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3 //убавление значения акселерометра
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
        
    }
    
}
