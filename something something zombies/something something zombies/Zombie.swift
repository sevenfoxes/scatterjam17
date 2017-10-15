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
    
    let shambleRightTextures: [SKTexture] = [SKTexture(imageNamed: "zombie"), SKTexture(imageNamed: "zombie-stand")]
    let shambleLeftTextures: [SKTexture] = [SKTexture(imageNamed: "zombie-left"), SKTexture(imageNamed: "zombie-stand-left")]
    
    override func animateLeft() {
        let shambleAnimation = SKAction.animate(with: shambleLeftTextures,
                                                timePerFrame: 0.4)
        let shambleForever = SKAction.repeatForever(shambleAnimation)
        
        self.run(shambleForever)
    }
    
    override func animateRight() {
        let shambleAnimation = SKAction.animate(with: shambleRightTextures,
                                                timePerFrame: 0.4)
        let shambleForever = SKAction.repeatForever(shambleAnimation)
        
        self.run(shambleForever)
    }
    
    init() {
        let texture = SKTexture(imageNamed: "zombie")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        moveSpeed = 10.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
