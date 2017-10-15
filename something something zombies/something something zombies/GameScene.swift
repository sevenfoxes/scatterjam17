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
    
    private var fear: Int = 300
    private var fearCharge: Double = 0
    private var fearLabel: SKLabelNode?
    private var frankensteins: [Frankenstein] = [Frankenstein]()
    private var fullMoonButton: SKSpriteNode?
    private var fullMoonEnabled: Bool = false
    private var inspireCourageCounter: Int = 0
    private var itsAliveButton: SKSpriteNode?
    private var itsAliveEnabled: Bool = false
    private var rage: Int = 0
    private var rageLabel: SKLabelNode?
    private var rageMomentum: Double = 1
    private var raiseDeadEnabled: Bool = false
    private var raiseDeadButton: SKSpriteNode?
    private var timer: Double?
    private var vanHelsing: VanHelsing = VanHelsing()
    private var zombies: [Zombie] = [Zombie]()
    private var wolfmen: [Wolfman] = [Wolfman]()
    
    internal let fearGoal: Int = 400
    internal let rageGoal: Int = 100
    
    var viewController: GameViewController?
    
    //Scene is moved to the view so initialize
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        let castle = SKSpriteNode(imageNamed: "castle")
        castle.position = CGPoint(x: 0, y: 441.82)
        castle.size = CGSize(width: 364.242, height: 316.366)
        addChild(castle)
        
        self.raiseDeadButton = SKSpriteNode(imageNamed: "raise-dead-disabled")
        raiseDeadButton?.position = CGPoint(x: -270.0, y: -540.0)
        self.fullMoonButton = SKSpriteNode(imageNamed: "full-moon-disabled")
        fullMoonButton?.position = CGPoint(x: -110.0, y: -540.0)
        self.itsAliveButton = SKSpriteNode(imageNamed: "its-alive-disabled")
        itsAliveButton?.position = CGPoint(x: 50.0, y: -540.0)
        self.fearLabel = self.childNode(withName: "//fearCount") as? SKLabelNode
        self.rageLabel = self.childNode(withName: "//rageCount") as? SKLabelNode
        
        self.addChild(raiseDeadButton!)
        self.addChild(fullMoonButton!)
        self.addChild(itsAliveButton!)
        
        let backgroundMusic = SKAudioNode(fileNamed: "bg.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        spawnZombie()
        spawnZombie()
        spawnZombie()

        vanHelsing.physicsBody = SKPhysicsBody(rectangleOf: vanHelsing.size)
        vanHelsing.physicsBody?.isDynamic = true
        vanHelsing.physicsBody?.categoryBitMask = PhysicsCategory.VanHelsing
        vanHelsing.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        vanHelsing.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        self.addChild(vanHelsing)
        vanHelsing.zPosition = 1;
        vanHelsing.spawn()
        vanHelsing.move()
    }
    
    //Raise Dead Button was touched
    func raiseDead() {
        if self.fear < 10 {
            return
        }
        self.fear = self.fear - 10
        
        spawnZombie()
    }
    
    //Full Moon Button was touched
    func fullMoon() {
        if self.fear < 50 {
            return
        }
        self.fear = self.fear - 50
        
        spawnWolfman()
    }
    
    //It's Alive Button was touched
    func itsAlive() {
        if self.fear < 100 {
            return
        }
        self.fear = self.fear - 100
        
        spawnFrankenstein()
    }
    
    //Create a zombie
    func spawnZombie() {
        let zombie: Zombie = Zombie()
        zombie.physicsBody = SKPhysicsBody(rectangleOf: zombie.size)
        zombie.physicsBody?.isDynamic = true
        zombie.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        zombie.physicsBody?.contactTestBitMask = PhysicsCategory.VanHelsing
        zombie.physicsBody?.collisionBitMask = PhysicsCategory.None
        zombie.zPosition = 1;
        
        self.addChild(zombie)
        zombie.spawn()
        zombie.move()
        
        self.zombies.append(zombie)
    }

    //Create a wolfman
    func spawnWolfman() {
        let wolfman: Wolfman = Wolfman()
        wolfman.physicsBody = SKPhysicsBody(rectangleOf: wolfman.size)
        wolfman.physicsBody?.isDynamic = true
        wolfman.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        wolfman.physicsBody?.contactTestBitMask = PhysicsCategory.VanHelsing
        wolfman.physicsBody?.collisionBitMask = PhysicsCategory.None
        wolfman.zPosition = 1
        
        self.addChild(wolfman)
        wolfman.spawn()
        wolfman.move()
        
        self.wolfmen.append(wolfman)
    }
    
    //Create a frankenstein
    func spawnFrankenstein() {
        let frankenstein: Frankenstein = Frankenstein()
        frankenstein.physicsBody = SKPhysicsBody(rectangleOf: frankenstein.size)
        frankenstein.physicsBody?.isDynamic = true
        frankenstein.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        frankenstein.physicsBody?.contactTestBitMask = PhysicsCategory.VanHelsing
        frankenstein.physicsBody?.collisionBitMask = PhysicsCategory.None
        frankenstein.zPosition = 1
        
        self.addChild(frankenstein)
        frankenstein.spawn()
        frankenstein.move()
        
        self.frankensteins.append(frankenstein)
    }

    //Called when Van Helsing collides with a monster (called by didBegin). Removes monster and increases rage
    func slayMonster(monster: Character) {
        rage = Int(Double(rage) + 1.0)
        //Test if zombie
        if let testMonster = monster as? Zombie {
            for (index, zombie) in zombies.enumerated() {
                if zombie == monster {
                    zombies.remove(at: index)
                }
            }
        }
        //Test if wolfman
        if let testMonster = monster as? Wolfman {
            for (index, wolfman) in wolfmen.enumerated() {
                if wolfman == monster {
                    wolfmen.remove(at: index)
                }
            }
        }
        //Test if frankenstein
        if let testMonster = monster as? Frankenstein {
            for (index, frankenstein) in frankensteins.enumerated() {
                if frankenstein == monster {
                    frankensteins.remove(at: index)
                }
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
                if n == self.fullMoonButton {
                    fullMoon()
                }
                if n == self.itsAliveButton {
                    itsAlive()
                }
            }
        }
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        if self.timer == nil {
            self.timer = currentTime
        }
        
        if raiseDeadEnabled == false && fear >= 10 {
            raiseDeadEnabled = true
            raiseDeadButton?.texture = SKTexture(imageNamed: "raise-dead")
        }
        if raiseDeadEnabled == true && fear < 10 {
            raiseDeadEnabled = false
            raiseDeadButton?.texture = SKTexture(imageNamed: "raise-dead-disabled")
        }
        if fullMoonEnabled == false && fear >= 50 {
            fullMoonEnabled = true
            fullMoonButton?.texture = SKTexture(imageNamed: "full-moon")
        }
        if fullMoonEnabled == true && fear < 50 {
            fullMoonEnabled = false
            fullMoonButton?.texture = SKTexture(imageNamed: "full-moon-disabled")
        }
        if itsAliveEnabled == false && fear >= 100 {
            itsAliveEnabled = true
            itsAliveButton?.texture = SKTexture(imageNamed: "its-alive")
        }
        if itsAliveEnabled == true && fear < 100 {
            itsAliveEnabled = false
            itsAliveButton?.texture = SKTexture(imageNamed: "its-alive-disabled")
        }

        if currentTime - self.timer! > 0.1 {
            fearCharge += 0.05 * Double(self.zombies.count)
            fearCharge += 0.3 * Double(self.wolfmen.count)
            fearCharge += 0.7 * Double(self.frankensteins.count)
            if fearCharge >= 1.0 && fear <= fearGoal { //Each monster contributes to incrementing fear amount. That's the fearCharge. When fearCharge is greater than 1, we actually increment the fear amount
                fear += Int(floor(fearCharge))
                fearCharge = fearCharge - Double(floor(fearCharge))
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
        if fear >= fearGoal && self.viewController != nil {
            self.viewController!.endGame(won: true)
        }
        
        //Trigger end game with losing message
        if rage >= rageGoal && self.viewController != nil {
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
            if let monster = secondBody.node as? Wolfman {
                slayMonster(monster: monster)
            }
            if let monster = secondBody.node as? Frankenstein {
                slayMonster(monster: monster)
            }
        }
    }
}
