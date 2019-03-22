//
//  GameBackgroudSpriteable+Extencion.swift
//  WarFly
//
//  Created by Admin on 22/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable {
    static func populate() -> Self //возвращ тип протокола или класса который используется
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100 , highestValue: Int(screen.size.height) + 200) //для рандомных значений
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
