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
    var zombieCount = 0
    
    @IBOutlet weak var buttonRounder: UIButton!
    @IBOutlet weak var zombieCountDisplay: UILabel!

    @IBAction func growZombie(_ sender: UIButton) {
        zombieCount += 1
        
        zombieCountDisplay.text = "There are \(zombieCount) zombies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonRounder.layer.cornerRadius = 4
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
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
