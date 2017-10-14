//
//  Zombie.swift
//  something something zombies
//
//  Created by Pedro Albea on 10/14/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie: SKLabelNode {
    
    let shambleSpeed: Double = 10.0
    
    override init() {
        super.init()
        self.text = "Z"
        self.fontColor = SKColor.green
        self.fontName = "Helvetica"
        self.fontSize = 48
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shamble() {
        //Generate a random position on the screen and move towards
        let target: CGPoint = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.width) - self.scene!.size.width / 2, y: CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.height) - self.scene!.size.height / 2)
        //Calculate distance
        let actualDistance = Double(sqrt(pow((target.x - self.position.x), 2) + pow((target.y - self.position.y), 2)))
        let actualDuration = actualDistance / shambleSpeed
        print("Distance: \(actualDistance)")
        print("Duration: \(actualDuration)")
        let actionShamble = SKAction.move(to: target, duration: TimeInterval(actualDuration))
        self.run(actionShamble) {
            self.shamble()
        }
    }
    
    func spawn() {
        //zombie position is based on the center of the screen so get the random x coordinate and then subtract it by half the screen width to get the right position. Same with y.
        let randomPosition = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.width) - self.scene!.size.width / 2,
                                     y: CGFloat(arc4random()).truncatingRemainder(dividingBy: self.scene!.size.height) - self.scene!.size.height / 2)
        self.position = randomPosition
    }
}
