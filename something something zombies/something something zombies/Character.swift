//
//  Character.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/14/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    
    var moveSpeed: Double = 10.0
    
    func move() {
        //Generate a random position on the screen and move towards
        let target: CGPoint = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.width) - self.scene!.size.width / 2, y: CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.height) - self.scene!.size.height / 2)
        //Calculate distance
        let actualDistance = Double(sqrt(pow((target.x - self.position.x), 2) + pow((target.y - self.position.y), 2)))
        let actualDuration = actualDistance / moveSpeed
        let actionMove = SKAction.move(to: target, duration: TimeInterval(actualDuration))
        self.run(actionMove) {
            self.move()
        }
    }
    
    func spawn() {
        //character position is based on the center of the screen so get the random x coordinate and then subtract it by half the screen width to get the right position. Same with y.
        let randomPosition = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.width) - self.scene!.size.width / 2,
                                     y: CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.height) - self.scene!.size.height / 2)
        self.position = randomPosition
    }
}
