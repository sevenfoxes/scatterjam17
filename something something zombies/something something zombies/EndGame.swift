//
//  EndGame.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/13/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class EndGame: SKScene {
    
    private var playAgainButton : SKLabelNode?
    private var messageLabel: SKLabelNode?
    var message: String?
    
    var viewController: GameViewController?
    
    override func didMove(to view: SKView) {
        messageLabel = self.childNode(withName: "//message") as? SKLabelNode
        if self.message != nil {
            messageLabel!.text = message
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.playAgainButton = self.childNode(withName: "//playAgain") as? SKLabelNode
        var touch: CGPoint
        for t in touches {
            touch = t.location(in: self)
            for n in self.nodes(at: touch) {
                if n == self.playAgainButton && viewController != nil {
                    viewController!.startGame()
                }
            }
        }
    }
}

