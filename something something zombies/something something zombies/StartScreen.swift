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
    
    private var startButton : SKLabelNode?
    
    var viewController: GameViewController?

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startButton = self.childNode(withName: "//startButton") as? SKLabelNode
        var touch: CGPoint
        for t in touches {
            touch = t.location(in: self)
            for n in self.nodes(at: touch) {
                if n.name == "startButton" && viewController != nil {
                    viewController!.startGame()
                }
            }
        }
    }
}
