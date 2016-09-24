//
//  LevelThreeViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class LevelThreeViewController: UIViewController {

        var originalPlayerBlockCenter: CGPoint!
        var originalPuzzleBlockCenterVertical: CGPoint!
        var originalPuzzleBlockCenterHorizontal: CGPoint!
        var orginalPuzzleBlockCenterOrange: CGPoint!
        var originalPuzzleBlockCenterGreen: CGPoint!
        var originalPuzzleBlockCenterBlue: CGPoint!
        var originalPuzzleBlockCenterBrown: CGPoint!
        var orginalPuzzleBlockCenterVerticalBrown: CGPoint!
        var originalPuzzleBlockCenterHorizontalGreen: CGPoint!
        var originalPuzzleBlockCenterVerticalGrey: CGPoint!
        var originalPuzzleBlockCenterVerticalRed : CGPoint!
        var collision: UICollisionBehavior!
        var animator: UIDynamicAnimator!
        // Debug Code
        let DEBUG_OUTPUT = false
        let DEBUG_FREE_PLAYER = false
        // Player Blocks
        //    let playerBlock = UIView(frame: CGRect(x: 10, y: 400, width: 79, height: 50))
        //
        //    // Puzzle Blocks
        //    let puzzleBlockVertical = UIView(frame: CGRect(x: 350, y: 460, width: 50, height: 175))
        //    let puzzleBlockHorizontal = UIView(frame: CGRect(x: 150, y: 550, width: 160, height: 50))
        //    let puzzleBlockVerticalOrange = UIView(frame: CGRect(x:80, y: 200, width:50, height:180))
        //    let puzzleBlockYellow = UIView(frame: CGRect(x:10, y: 500, width:100, height:50))
        //    // let sampleimage = UIImageView(frame: CGRect(x: 10, y: 400, width: 50, height: 50))
        @IBOutlet weak var puzzleBlockVerticalOrange: UIImageView!
        @IBOutlet weak var puzzleBlockHorizontal: UIImageView!
        @IBOutlet weak var puzzleBlockVertical: UIImageView!
        @IBOutlet weak var playerBlock: UIImageView!
        @IBOutlet weak var puzzleBlockVerticalGreen: UIImageView!
        @IBOutlet weak var puzzleBlockHorizontalBrown: UIImageView!
        @IBOutlet weak var puzzleBlockHorizontalBlue: UIImageView!
        @IBOutlet weak var puzzleBlockVerticalRed: UIImageView!
        @IBOutlet weak var puzzleBlockVerticalGrey: UIImageView!
        @IBOutlet weak var puzzleBlockHorizontalGreen: UIImageView!
        @IBOutlet weak var puzzleBlockVerticalBrown: UIImageView!
        
        // Barriers
        let barrierUpper = UIView(frame: CGRect(x: 0, y: -300, width: 414, height: 500))
        let barrierLeft = UIView(frame: CGRect(x: -100, y: 200, width: 114, height: 736))
        let barrierUpperRight = UIView(frame: CGRect(x: 400, y: 200, width: 414, height: 190))
        let barrierLowerRight = UIView(frame: CGRect(x: 400, y: 460, width: 414, height: 190))
        let barrierLower = UIView(frame: CGRect(x: 0, y: 636, width: 414, height: 400))
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Create Blocks
            //        playerBlock.backgroundColor = UIColor.green
            //        view.addSubview(playerBlock)
            
            // Create Puzzle Blocks
            //        puzzleBlockVertical.backgroundColor = UIColor.brown
            //        view.addSubview(puzzleBlockVertical)
            //        puzzleBlockHorizontal.backgroundColor = UIColor.magenta
            //        view.addSubview(puzzleBlockHorizontal)
            //        puzzleBlockVerticalOrange.backgroundColor = UIColor.orange
            //        view.addSubview(puzzleBlockVerticalOrange)
            //        puzzleBlockYellow.backgroundColor = UIColor.yellow
            //        view.addSubview(puzzleBlockYellow)
            
            //Set Gesture Controls
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPlayerBlockPan1(_:)))
            playerBlock.isUserInteractionEnabled = true
            playerBlock.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPan(_:)))
            puzzleBlockVertical.isUserInteractionEnabled = true
            puzzleBlockVertical.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanHorizontalRed(_:)))
            puzzleBlockHorizontal.isUserInteractionEnabled = true
            puzzleBlockHorizontal.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanOrange(_:)))
            puzzleBlockVerticalOrange.isUserInteractionEnabled = true
            puzzleBlockVerticalOrange.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanBlue(_:)))
            puzzleBlockHorizontalBlue.isUserInteractionEnabled = true
            puzzleBlockHorizontalBlue.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanBrown(_:)))
            puzzleBlockHorizontalBrown.isUserInteractionEnabled = true
            puzzleBlockHorizontalBrown.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanGreen(_:)))
            puzzleBlockVerticalGreen.isUserInteractionEnabled = true
            puzzleBlockVerticalGreen.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanHorizontalGreen(_:)))
            puzzleBlockHorizontalGreen.isUserInteractionEnabled = true
            puzzleBlockHorizontalGreen.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanVerticalBrown(_:)))
            puzzleBlockVerticalBrown.isUserInteractionEnabled = true
            puzzleBlockVerticalBrown.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanVerticalGrey(_:)))
            puzzleBlockVerticalGrey.isUserInteractionEnabled = true
            puzzleBlockVerticalGrey.addGestureRecognizer(panGestureRecognizer)
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelThreeViewController.didPuzzleBlockPanVerticalRed(_:)))
            puzzleBlockVerticalRed.isUserInteractionEnabled = true
            puzzleBlockVerticalRed.addGestureRecognizer(panGestureRecognizer)
            
            


            
            // Set Barriers
            barrierUpper.backgroundColor = UIColor.clear
            barrierLeft.backgroundColor = UIColor.clear
            barrierUpperRight.backgroundColor = UIColor.clear
            barrierLowerRight.backgroundColor = UIColor.clear
            barrierLower.backgroundColor = UIColor.clear
            view.addSubview(barrierUpper)
            view.addSubview(barrierLeft)
            view.addSubview(barrierUpperRight)
            view.addSubview(barrierLowerRight)
            view.addSubview(barrierLower)
            
            //Set Collisions
            animator = UIDynamicAnimator(referenceView: view)
            collision = UICollisionBehavior(items: [playerBlock,puzzleBlockVertical,puzzleBlockHorizontal])
            collision.translatesReferenceBoundsIntoBoundary = true
            collision.addBoundary(withIdentifier: "barrierUpper", for: UIBezierPath(rect: barrierUpper.frame))
            collision.addBoundary(withIdentifier: "barrierLeft", for: UIBezierPath(rect: barrierLeft.frame))
            collision.addBoundary(withIdentifier: "barrierUpperRight", for: UIBezierPath(rect: barrierUpperRight.frame))
            collision.addBoundary(withIdentifier: "barrierLowerRight", for: UIBezierPath(rect: barrierLowerRight.frame))
            collision.addBoundary(withIdentifier: "barrierLower", for: UIBezierPath(rect: barrierLower.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVertical", for: UIBezierPath(rect: puzzleBlockVertical.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockHorizontal", for: UIBezierPath(rect: puzzleBlockHorizontal.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVerticalOrange", for: UIBezierPath(rect: puzzleBlockVerticalOrange.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockHorizontalBlue", for: UIBezierPath(rect: puzzleBlockHorizontalBlue.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockHorizontalBrown", for: UIBezierPath(rect: puzzleBlockHorizontalBrown.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVerticalGreen", for: UIBezierPath(rect: puzzleBlockVerticalGreen.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockHorizontalGreen", for: UIBezierPath(rect: puzzleBlockHorizontalGreen.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVerticalBrown", for: UIBezierPath(rect: puzzleBlockVerticalBrown.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVerticalGrey", for: UIBezierPath(rect: puzzleBlockVerticalGrey.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockVerticalRed", for: UIBezierPath(rect: puzzleBlockVerticalRed.frame))
            collision.addBoundary(withIdentifier: "puzzleBlockHorizontalBlue", for: UIBezierPath(rect: puzzleBlockHorizontalBlue.frame))
            
            animator.addBehavior(collision)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        @IBAction func didPlayerBlockPan1(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPlayerBlockCenter = playerBlock.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(playerBlock.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPlayerBlockCenter.y + translation.y + unstuck
                        playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPlayerBlockCenter.y + translation.y - unstuck
                        playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                        playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                        playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                        playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(puzzleBlockVertical.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVertical.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }else{
                        while(puzzleBlockVertical.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalOrange.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalOrange.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }else{
                        while(puzzleBlockVerticalOrange.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGreen.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGreen.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGreen.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGrey.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGrey.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGrey.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalBrown.frame.intersects(playerBlock.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalBrown.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }else{
                        while(puzzleBlockVerticalBrown.frame.intersects(playerBlock.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                            playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x + translation.x, y: originalPlayerBlockCenter.y + translation.y)
                    }else{
                        playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x + translation.x , y: originalPlayerBlockCenter.y)
                    }
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        
        @IBAction func didPuzzleBlockPan(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPuzzleBlockCenterVertical = puzzleBlockVertical.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockVertical.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockVertical.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                        puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockVertical.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                        puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockVertical.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterVertical.x + translation.x + unstuck
                        puzzleBlockVertical.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVertical.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockVertical.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterVertical.x + translation.x - unstuck
                        puzzleBlockVertical.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVertical.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockVertical.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterVertical.x + translation.x - unstuck
                        puzzleBlockVertical.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVertical.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(playerBlock.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(playerBlock.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }else{
                        while(playerBlock.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVertical.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y - unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVertical.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterVertical.y + translation.y + unstuck
                            puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x + translation.x, y: originalPuzzleBlockCenterVertical.y + translation.y)
                    }else{
                        puzzleBlockVertical.center = CGPoint(x: originalPuzzleBlockCenterVertical.x, y: originalPuzzleBlockCenterVertical.y + translation.y)
                    }
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
    
        @IBAction func didPuzzleBlockPanHorizontalRed(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPuzzleBlockCenterHorizontal = puzzleBlockHorizontal.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockHorizontal.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterHorizontal.y + translation.y + unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: originalPuzzleBlockCenterHorizontal.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterHorizontal.y + translation.y - unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: originalPuzzleBlockCenterHorizontal.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x -  unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontal.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }else{
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontal.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x + unstuck
                            puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockHorizontal.center = CGPoint(x: originalPuzzleBlockCenterHorizontal.x + translation.x, y: originalPuzzleBlockCenterHorizontal.y + translation.y)
                    }else{
                        puzzleBlockHorizontal.center = CGPoint(x: originalPuzzleBlockCenterHorizontal.x + translation.x , y: originalPuzzleBlockCenterHorizontal.y)
                    }
                    
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        
        @IBAction func didPuzzleBlockPanOrange(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                orginalPuzzleBlockCenterOrange = puzzleBlockVerticalOrange.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockVerticalOrange.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockVerticalOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                        puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockVerticalOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                        puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockVerticalOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = orginalPuzzleBlockCenterOrange.x + translation.x + unstuck
                        puzzleBlockVerticalOrange.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterOrange.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockVerticalOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = orginalPuzzleBlockCenterOrange.x + translation.x - unstuck
                        puzzleBlockVerticalOrange.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterOrange.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockVerticalOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = orginalPuzzleBlockCenterOrange.x + translation.x - unstuck
                        puzzleBlockVerticalOrange.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterOrange.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(playerBlock.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(playerBlock.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }else{
                        while(playerBlock.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalOrange.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y - unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalOrange.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = orginalPuzzleBlockCenterOrange.y + translation.y + unstuck
                            puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x + translation.x, y: orginalPuzzleBlockCenterOrange.y + translation.y)
                    }else{
                        puzzleBlockVerticalOrange.center = CGPoint(x: orginalPuzzleBlockCenterOrange.x, y: orginalPuzzleBlockCenterOrange.y + translation.y)
                    }
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        @IBAction func didPuzzleBlockPanGreen(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPuzzleBlockCenterGreen = puzzleBlockVerticalGreen.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockVerticalGreen.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockVerticalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                        puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockVerticalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                        puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockVerticalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterGreen.x + translation.x + unstuck
                        puzzleBlockVerticalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterGreen.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockVerticalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterGreen.x + translation.x - unstuck
                        puzzleBlockVerticalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterGreen.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockVerticalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterGreen.x + translation.x - unstuck
                        puzzleBlockVerticalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterGreen.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(playerBlock.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(playerBlock.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }else{
                        while(playerBlock.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGreen.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.y
                    if(translationDirection >= 0){
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuc val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y - unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }else{
                        while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGreen.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_y = originalPuzzleBlockCenterGreen.y + translation.y + unstuck
                            puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: new_y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x + translation.x, y: originalPuzzleBlockCenterGreen.y + translation.y)
                    }else{
                        puzzleBlockVerticalGreen.center = CGPoint(x: originalPuzzleBlockCenterGreen.x, y: originalPuzzleBlockCenterGreen.y + translation.y)
                    }
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        @IBAction func didPuzzleBlockPanBlue(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPuzzleBlockCenterBlue = puzzleBlockHorizontalBlue.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockHorizontalBlue.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterBlue.y + translation.y + unstuck
                        puzzleBlockHorizontalBlue.center = CGPoint(x: originalPuzzleBlockCenterBlue.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterBlue.y + translation.y - unstuck
                        puzzleBlockHorizontalBlue.center = CGPoint(x: originalPuzzleBlockCenterBlue.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                        puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                        puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBlue.x + translation.x -  unstuck
                        puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x - unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBlue.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBlue.x + translation.x + unstuck
                            puzzleBlockHorizontalBlue.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBlue.y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockHorizontalBlue.center = CGPoint(x: originalPuzzleBlockCenterBlue.x + translation.x, y: originalPuzzleBlockCenterBlue.y + translation.y)
                    }else{
                        puzzleBlockHorizontalBlue.center = CGPoint(x: originalPuzzleBlockCenterBlue.x + translation.x , y: originalPuzzleBlockCenterBlue.y)
                    }
                    
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        @IBAction func didPuzzleBlockPanBrown(_ sender: UIPanGestureRecognizer) {
            //var point = sender.location(in: view)
            //var velocity = sender.velocity(in: view)
            let translation = sender.translation(in: view)
            
            if sender.state == UIGestureRecognizerState.began {
                originalPuzzleBlockCenterBrown = puzzleBlockHorizontalBrown.center
            } else if sender.state == UIGestureRecognizerState.changed {
                if (barrierUpper.frame.intersects(puzzleBlockHorizontalBrown.frame)) {     // Block has intersected with boundry, get unstuck.
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpper.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterBrown.y + translation.y + unstuck
                        puzzleBlockHorizontalBrown.center = CGPoint(x: originalPuzzleBlockCenterBrown.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLower.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLower.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterBrown.y + translation.y - unstuck
                        puzzleBlockHorizontalBrown.center = CGPoint(x: originalPuzzleBlockCenterBrown.x, y: new_y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLeft.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLeft.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                        puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y)
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierUpperRight.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierUpperRight.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                        puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(barrierLowerRight.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false    //Disables Gestures
                    var unstuck: CGFloat = 0.00
                    while(barrierLowerRight.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterBrown.x + translation.x -  unstuck
                        puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                    }
                    sender.isEnabled = true     // Enables Gesture
                }else if(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else if(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                    sender.isEnabled = false //Disables Gesture
                    var unstuck: CGFloat = 0.00
                    let translationDirection = translation.x
                    if(translationDirection >= 0){
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x - unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }else{
                        while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalBrown.frame)){
                            unstuck += 0.01
                            if(DEBUG_OUTPUT){
                                print("Unstuck val: \(unstuck)")
                            }
                            let new_x = originalPuzzleBlockCenterBrown.x + translation.x + unstuck
                            puzzleBlockHorizontalBrown.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterBrown.y )
                        }
                    }
                    sender.isEnabled = true
                }else{
                    if(DEBUG_FREE_PLAYER){
                        puzzleBlockHorizontalBrown.center = CGPoint(x: originalPuzzleBlockCenterBrown.x + translation.x, y: originalPuzzleBlockCenterBrown.y + translation.y)
                    }else{
                        puzzleBlockHorizontalBrown.center = CGPoint(x: originalPuzzleBlockCenterBrown.x + translation.x , y: originalPuzzleBlockCenterBrown.y)
                    }
                    
                }
            } else if sender.state == UIGestureRecognizerState.ended {
                //Nothing!
            }
        }
        
    @IBAction func didPuzzleBlockPanHorizontalGreen(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalPuzzleBlockCenterHorizontalGreen = puzzleBlockHorizontalGreen.center
        } else if sender.state == UIGestureRecognizerState.changed {
            if (barrierUpper.frame.intersects(puzzleBlockHorizontalGreen.frame)) {     // Block has intersected with boundry, get unstuck.
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpper.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterHorizontalGreen.y + translation.y + unstuck
                    puzzleBlockHorizontalGreen.center = CGPoint(x: originalPuzzleBlockCenterHorizontalGreen.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLower.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLower.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterHorizontalGreen.y + translation.y - unstuck
                    puzzleBlockHorizontalGreen.center = CGPoint(x: originalPuzzleBlockCenterHorizontalGreen.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLeft.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLeft.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                    puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y)
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierUpperRight.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpperRight.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                    puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLowerRight.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLowerRight.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x -  unstuck
                    puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVertical.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVerticalOrange.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVerticalGreen.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVerticalRed.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVerticalGrey.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x - unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }else{
                    while(puzzleBlockVerticalBrown.frame.intersects(puzzleBlockHorizontalGreen.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontalGreen.x + translation.x + unstuck
                        puzzleBlockHorizontalGreen.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontalGreen.y )
                    }
                }
                sender.isEnabled = true
            }else{
                if(DEBUG_FREE_PLAYER){
                    puzzleBlockHorizontalGreen.center = CGPoint(x: originalPuzzleBlockCenterHorizontalGreen.x + translation.x, y: originalPuzzleBlockCenterHorizontalGreen.y + translation.y)
                }else{
                    puzzleBlockHorizontalGreen.center = CGPoint(x: originalPuzzleBlockCenterHorizontalGreen.x + translation.x , y: originalPuzzleBlockCenterHorizontalGreen.y)
                }
                
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            //Nothing!
        }
    }
    @IBAction func didPuzzleBlockPanVerticalGrey(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalPuzzleBlockCenterVerticalGrey = puzzleBlockVerticalGrey.center
        } else if sender.state == UIGestureRecognizerState.changed {
            if (barrierUpper.frame.intersects(puzzleBlockVerticalGrey.frame)) {     // Block has intersected with boundry, get unstuck.
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpper.frame.intersects(puzzleBlockVerticalGrey.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                    puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLower.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLower.frame.intersects(puzzleBlockVerticalGrey.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                    puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLeft.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLeft.frame.intersects(puzzleBlockVerticalGrey.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalGrey.x + translation.x + unstuck
                    puzzleBlockVerticalGrey.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalGrey.y)
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierUpperRight.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpperRight.frame.intersects(puzzleBlockVerticalGrey.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalGrey.x + translation.x - unstuck
                    puzzleBlockVerticalGrey.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalGrey.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLowerRight.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLowerRight.frame.intersects(puzzleBlockVerticalGrey.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalGrey.x + translation.x - unstuck
                    puzzleBlockVerticalGrey.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalGrey.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(playerBlock.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(playerBlock.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }else{
                    while(playerBlock.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGrey.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y - unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalGrey.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalGrey.y + translation.y + unstuck
                        puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else{
                if(DEBUG_FREE_PLAYER){
                    puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x + translation.x, y: originalPuzzleBlockCenterVerticalGrey.y + translation.y)
                }else{
                    puzzleBlockVerticalGrey.center = CGPoint(x: originalPuzzleBlockCenterVerticalGrey.x, y: originalPuzzleBlockCenterVerticalGrey.y + translation.y)
                }
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            //Nothing!
        }
    }
    @IBAction func didPuzzleBlockPanVerticalBrown(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            orginalPuzzleBlockCenterVerticalBrown = puzzleBlockVerticalBrown.center
        } else if sender.state == UIGestureRecognizerState.changed {
            if (barrierUpper.frame.intersects(puzzleBlockVerticalBrown.frame)) {     // Block has intersected with boundry, get unstuck.
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpper.frame.intersects(puzzleBlockVerticalBrown.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                    puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLower.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLower.frame.intersects(puzzleBlockVerticalBrown.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                    puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLeft.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLeft.frame.intersects(puzzleBlockVerticalBrown.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBlockCenterVerticalBrown.x + translation.x + unstuck
                    puzzleBlockVerticalBrown.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterVerticalBrown.y)
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierUpperRight.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpperRight.frame.intersects(puzzleBlockVerticalBrown.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBlockCenterVerticalBrown.x + translation.x - unstuck
                    puzzleBlockVerticalBrown.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterVerticalBrown.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLowerRight.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLowerRight.frame.intersects(puzzleBlockVerticalBrown.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBlockCenterVerticalBrown.x + translation.x - unstuck
                    puzzleBlockVerticalBrown.center = CGPoint(x: new_x, y: orginalPuzzleBlockCenterVerticalBrown.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(playerBlock.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(playerBlock.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }else{
                    while(playerBlock.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalBrown.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y - unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalBrown.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBlockCenterVerticalBrown.y + translation.y + unstuck
                        puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else{
                if(DEBUG_FREE_PLAYER){
                    puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x + translation.x, y: orginalPuzzleBlockCenterVerticalBrown.y + translation.y)
                }else{
                    puzzleBlockVerticalBrown.center = CGPoint(x: orginalPuzzleBlockCenterVerticalBrown.x, y: orginalPuzzleBlockCenterVerticalBrown.y + translation.y)
                }
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            //Nothing!
        }
    }
    @IBAction func didPuzzleBlockPanVerticalRed(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalPuzzleBlockCenterVerticalRed = puzzleBlockVerticalRed.center
        } else if sender.state == UIGestureRecognizerState.changed {
            if (barrierUpper.frame.intersects(puzzleBlockVerticalRed.frame)) {     // Block has intersected with boundry, get unstuck.
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpper.frame.intersects(puzzleBlockVerticalRed.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                    puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLower.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLower.frame.intersects(puzzleBlockVerticalRed.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                    puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLeft.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLeft.frame.intersects(puzzleBlockVerticalRed.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalRed.x + translation.x + unstuck
                    puzzleBlockVerticalRed.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalRed.y)
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierUpperRight.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpperRight.frame.intersects(puzzleBlockVerticalRed.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalRed.x + translation.x - unstuck
                    puzzleBlockVerticalRed.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalRed.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLowerRight.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLowerRight.frame.intersects(puzzleBlockVerticalRed.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPuzzleBlockCenterVerticalRed.x + translation.x - unstuck
                    puzzleBlockVerticalRed.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVerticalRed.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(playerBlock.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(playerBlock.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }else{
                    while(playerBlock.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBlue.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalBrown.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalRed.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y - unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontalGreen.frame.intersects(puzzleBlockVerticalRed.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = originalPuzzleBlockCenterVerticalRed.y + translation.y + unstuck
                        puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else{
                if(DEBUG_FREE_PLAYER){
                    puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x + translation.x, y: originalPuzzleBlockCenterVerticalRed.y + translation.y)
                }else{
                    puzzleBlockVerticalRed.center = CGPoint(x: originalPuzzleBlockCenterVerticalRed.x, y: originalPuzzleBlockCenterVerticalRed.y + translation.y)
                }
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            //Nothing!
        }
    }
        func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    
        /*
         // MARK: - Navigation
     
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
    
}
