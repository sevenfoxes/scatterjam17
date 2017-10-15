//
//  GameScene.swift
//  something something zombies
//
//  Created by scott.nesham on 10/13/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import SpriteKit
import GameplayKit

//Define physics categories
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let VanHelsing   : UInt32 = 0b1       // 1
    static let Monster: UInt32 = 0b10            // 2
    static let Zombie: UInt32 = 0b110            // 6
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    
    //Scene is moved to the view so initialize
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        self.raiseDeadButton = self.childNode(withName: "//raiseDead") as? SKLabelNode
        self.fearLabel = self.childNode(withName: "//fearCount") as? SKLabelNode
        self.rageLabel = self.childNode(withName: "//rageCount") as? SKLabelNode
        
        let backgroundMusic = SKAudioNode(fileNamed: "bg.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)

        //TODO: calculate the size this way after we switch from SKLabelNodes to SKSpriteNodes
        //vanHelsing.physicsBody = SKPhysicsBody(rectangleOf: vanHelsing.size)
        vanHelsing.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30.0,
                                                                   height: 30.0))
        vanHelsing.physicsBody?.isDynamic = true
        vanHelsing.physicsBody?.categoryBitMask = PhysicsCategory.VanHelsing
        vanHelsing.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        vanHelsing.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        self.addChild(vanHelsing)
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
        //TODO: calculate the size this way after we switch from SKLabelNodes to SKSpriteNodes
        //zombie.physicsBody = SKPhysicsBody(rectangleOf: zombie.size)
        zombie.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30.0,
                                                               height: 30.0))
        zombie.physicsBody?.isDynamic = true
        zombie.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        zombie.physicsBody?.contactTestBitMask = PhysicsCategory.VanHelsing
        zombie.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        self.addChild(zombie)
        zombie.spawn()
        zombie.move()
        
        self.zombies.append(zombie)
    }
    
    //Called when Van Helsing collides with a monster (called by didBegin). Removes zombie and increases rage
    func slayMonster(monster: Zombie) {
        rage = Int(Double(rage) + 5.0)
        for (index, zombie) in zombies.enumerated() {
            if zombie == monster {
                zombies.remove(at: index)
            }
        }
        monster.removeFromParent()
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
            
            //Handle Van Helsing Inspiring Courage
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
    
    //Called when a collision is detected
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.VanHelsing != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Monster != 0)) {
            if let monster = secondBody.node as? Zombie {
                slayMonster(monster: monster)
            }
        }
    }
}
