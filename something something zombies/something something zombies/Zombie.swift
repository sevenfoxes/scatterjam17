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
    
    override init() {
        super.init()
        self.text = "Z"
        self.fontColor = SKColor.green
        self.fontName = "Helvetica"
        self.fontSize = 48
        moveSpeed = 10.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
