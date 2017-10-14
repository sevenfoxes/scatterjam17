//
//  GameScene.swift
//  something something zombies
//
//  Created by scott.nesham on 10/13/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var tapCount: Int = 0
    private var fear: Int = 50
    private var rage: Int = 0
    private var raiseDeadButton: SKLabelNode?
    private var rageLabel: SKLabelNode?
    private var fearLabel: SKLabelNode?
    private var fearCharge: Double = 0
    private var zombies: [SKLabelNode] = [SKLabelNode]()
    private var timer: Double?
    private var vanHelsing: Double = 0
    private var rageMomentum: Double = 1
    
    var viewController: GameViewController?
    
    override func didMove(to view: SKView) {
        self.raiseDeadButton = self.childNode(withName: "//raiseDead") as? SKLabelNode
        self.fearLabel = self.childNode(withName: "//fearCount") as? SKLabelNode
        self.rageLabel = self.childNode(withName: "//rageCount") as? SKLabelNode
    }
    
    func raiseDead() {
        if self.fear < 10 {
            return
        }
        self.fear = self.fear - 10
        
        let zombie: SKLabelNode = SKLabelNode()
        zombie.text = "Z"
        zombie.fontColor = SKColor.green
        zombie.fontName = "Helvetica"
        zombie.fontSize = 48
        //zombie position is based on the center of the screen so get the random x coordinate and then subtract it by half the screen width to get the right position. Same with y.
        let randomPosition = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width) - size.width / 2,
                                     y: CGFloat(arc4random()).truncatingRemainder(dividingBy: size.height) - size.height / 2)
        zombie.position = randomPosition
        self.addChild(zombie)
        self.zombies.append(zombie)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: CGPoint
        for t in touches {
            touch = t.location(in: self)
            for n in self.nodes(at: touch) {
                if n == self.raiseDeadButton {
                    raiseDead()
                }
            }
        }
    }
        
    override func update(_ currentTime: TimeInterval) {
        if self.timer == nil {
            self.timer = currentTime
        }
        
        if currentTime - self.timer! > 0.1 {
            fearCharge += 0.05 * Double(self.zombies.count)
            if fearCharge >= 1.0 && fear < 101 { //Each monster contributes to incrementing fear amount. That's the fearCharge. When fearCharge is greater than 1, we actually increment the fear amount
                fear += 1
                fearCharge = fearCharge - 1.0
            }
            
            //Handle Van Helsing killing zombies
            vanHelsing += 1
            if (vanHelsing > 50) {
                if zombies.count > 0 {
                    rageMomentum = 1.0
                } else {
                    rageMomentum = rageMomentum * 1.5 //Rage increases faster if there are no monsters to fight
                }
                rage = Int(Double(rage) + rageMomentum)
                vanHelsing = 0
                if zombies.count > 0 {
                    let killedZombie = zombies.popLast()
                    self.removeChildren(in: [killedZombie!])
                }
            }
            
            self.timer = currentTime
        }
        
        //TODO: alter end game message based on end condition
        if fear >= 100 && self.viewController != nil {
            self.viewController!.endGame()
        }
        
        //TODO: alter end game message based on end condition
        if rage >= 100 && self.viewController != nil {
            self.viewController!.endGame()
        }
        
        // Called before each frame is rendered
        if self.fearLabel != nil {
            self.fearLabel!.text = String(self.fear)
        }
        if self.rageLabel != nil {
            self.rageLabel!.text = String(self.rage)
        }
    }
}
