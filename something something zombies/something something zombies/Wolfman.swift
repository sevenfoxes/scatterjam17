//
//  Wolfman.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/15/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class Wolfman: Character {
    
    let runRightTextures: [SKTexture] = [SKTexture(imageNamed: "wolfman"), SKTexture(imageNamed: "wolfman-step")]
    let runLeftTextures: [SKTexture] = [SKTexture(imageNamed: "wolfman-left"), SKTexture(imageNamed: "wolfman-step-left")]
    
    override func animateLeft() {
        let runAnimation = SKAction.animate(with: runLeftTextures,
                                                timePerFrame: 0.4)
        let runForever = SKAction.repeatForever(runAnimation)
        
        self.run(runForever)
    }
    
    override func animateRight() {
        let runAnimation = SKAction.animate(with: runRightTextures,
                                                timePerFrame: 0.4)
        let runForever = SKAction.repeatForever(runAnimation)
        
        self.run(runForever)
    }
    
    init() {
        let texture = SKTexture(imageNamed: "wolfman")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        moveSpeed = 50.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
