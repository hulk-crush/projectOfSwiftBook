//
//  BluePowerUp.swift
//  WarFly
//
//  Created by Admin on 26/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//


import SpriteKit

class BluePowerUp: PowerUp {
    
    init() {
        let textureAtlas = SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
