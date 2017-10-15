//
//  Zombie.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/14/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie: Character {
    
    init() {
        let texture = SKTexture(imageNamed: "zombie")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        moveSpeed = 10.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
