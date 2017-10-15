//
//  Frankenstein.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/15/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class Frankenstein: Character {
    
    let stumbleRightTextures: [SKTexture] = [SKTexture(imageNamed: "frankenstein"), SKTexture(imageNamed: "frankenstein-step")]
    let stumbleLeftTextures: [SKTexture] = [SKTexture(imageNamed: "frankenstein-left"), SKTexture(imageNamed: "frankenstein-step-left")]
    
    override func animateLeft() {
        let stumbleAnimation = SKAction.animate(with: stumbleLeftTextures,
                                            timePerFrame: 0.4)
        let stumbleForever = SKAction.repeatForever(stumbleAnimation)
        
        self.run(stumbleForever)
    }
    
    override func animateRight() {
        let stumbleAnimation = SKAction.animate(with: stumbleRightTextures,
                                            timePerFrame: 0.4)
        let stumbleForever = SKAction.repeatForever(stumbleAnimation)
        
        self.run(stumbleForever)
    }
    
    init() {
        let texture = SKTexture(imageNamed: "frankenstein")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        moveSpeed = 50.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

