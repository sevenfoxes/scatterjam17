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
    private var vanHelsing: VanHelsing = VanHelsing()
    private var inspireCourageCounter: Int = 0
    private var rageMomentum: Double = 1
    
    var viewController: GameViewController?
    
    override func didMove(to view: SKView) {
        self.raiseDeadButton = self.childNode(withName: "//raiseDead") as? SKLabelNode
        self.fearLabel = self.childNode(withName: "//fearCount") as? SKLabelNode
        self.rageLabel = self.childNode(withName: "//rageCount") as? SKLabelNode
        self.addChild(self.vanHelsing)
        vanHelsing.spawn()
        vanHelsing.move()
    }
    
    //Raise Dead Button was touched
    func raiseDead() {
        if self.fear < 10 {
            return
        }
        self.fear = self.fear - 10
        
        let zombie: Zombie = Zombie()
        self.addChild(zombie)
        zombie.spawn()
        zombie.move()
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
    
    // Called before each frame is rendered
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
            inspireCourageCounter += 1
            if (inspireCourageCounter > 100) {
                //TODO: call some inspireCourage method on vanHelsing to animate action
                if zombies.count > 0 {
                    rageMomentum = 1.0
                } else {
                    rageMomentum = rageMomentum * 1.5 //Rage increases faster if there are no monsters to fight
                }
                rage = Int(Double(rage) + rageMomentum)
                inspireCourageCounter = 0
                /* move this to collision detection
                if zombies.count > 0 {
                    rage = Int(Double(rage) + 5.0)
                    let killedZombie = zombies.popLast()
                    self.removeChildren(in: [killedZombie!])
                }
                */
            }
            
            self.timer = currentTime
        }

        //Trigger end game with winning message
        if fear >= 100 && self.viewController != nil {
            self.viewController!.endGame(won: true)
        }
        
        //Trigger end game with losing message
        if rage >= 100 && self.viewController != nil {
            self.viewController!.endGame(won: false)
        }
        
        if self.fearLabel != nil {
            self.fearLabel!.text = String(self.fear)
        }
        if self.rageLabel != nil {
            self.rageLabel!.text = String(self.rage)
        }
    }
}
