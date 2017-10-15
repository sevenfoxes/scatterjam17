//
//  VanHelsing.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/14/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class VanHelsing: Character {
    
    init() {
        let texture = SKTexture(imageNamed: "van-helsing")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        moveSpeed = 100.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func spawn() {
        //Spawn Van Helsing at the center of the screen
        let startingPosition = CGPoint(x: 0.0, y: 0.0)
        self.position = startingPosition
    }
}
