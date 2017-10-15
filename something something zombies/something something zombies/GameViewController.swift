//
//  GameViewController.swift
//  something something zombies
//
//  Created by scott.nesham on 10/13/17.
//  Copyright © 2017 BOWLING FOR VAMPIRES. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    func endGame(won: Bool) {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'EndGame.sks'
            if let scene = EndGame(fileNamed: "EndGame") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.viewController = self
                scene.message = "Fear rules the land."
                scene.message2 = "Congratulations!"
                if won == false {
                    scene.message = "The villagers drove you out."
                    scene.message2 = "Better luck next time!"
                }
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func startGame() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.viewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'StartScreen.sks'
            if let scene = StartScreen(fileNamed: "StartScreen") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.viewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
