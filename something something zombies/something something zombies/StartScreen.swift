//
//  StartScreen.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/13/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class StartScreen: SKScene {
    
    private var titleLabel : SKLabelNode?
    private var startButton : SKLabelNode?
    
    var viewController: GameViewController?

    override func didMove(to view: SKView) {
        titleLabel = self.childNode(withName: "//title") as? SKLabelNode
        startButton = self.childNode(withName: "//startButton") as? SKLabelNode
        
        startButton!.zPosition = 1
        titleLabel!.zPosition = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: CGPoint
        for t in touches {
            touch = t.location(in: self)
            for n in self.nodes(at: touch) {
                if n == self.startButton && viewController != nil {
                    viewController!.startGame()
                }
            }
        }
    }
}
