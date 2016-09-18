//
//  LevelOneViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/15/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class LevelOneViewController: UIViewController {

    
    var originalPlayerBlockCenter: CGPoint!
    var originalPuzzleBlockCenterVertical: CGPoint!
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    // Debug Code
    let DEBUG_OUTPUT = false
    let DEBUG_FREE_PLAYER = false
    // Player Blocks
    let playerBlock = UIView(frame: CGRect(x: 100, y: 400, width: 50, height: 50))
    // Puzzle Blocks
    let puzzleBlockVertical = UIView(frame: CGRect(x: 180, y: 400, width: 50, height: 100))

     
    // Barriers
    let barrierUpper = UIView(frame: CGRect(x: 0, y: -300, width: 414, height: 500))
    let barrierLeft = UIView(frame: CGRect(x: -100, y: 200, width: 114, height: 736))
    let barrierUpperRight = UIView(frame: CGRect(x: 400, y: 200, width: 414, height: 190))
    let barrierLowerRight = UIView(frame: CGRect(x: 400, y: 460, width: 414, height: 190))
    let barrierLower = UIView(frame: CGRect(x: 0, y: 636, width: 414, height: 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Blocks
        playerBlock.backgroundColor = UIColor.green
        view.addSubview(playerBlock)
        
        // Create Puzzle Blocks
        puzzleBlockVertical.backgroundColor = UIColor.red
        view.addSubview(puzzleBlockVertical)
        
        //Set Gesture Controls
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPlayerBlockPan(_:)))
        playerBlock.isUserInteractionEnabled = true
        playerBlock.addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPuzzleBlockPan(_:)))
        puzzleBlockVertical.isUserInteractionEnabled = true
        puzzleBlockVertical.addGestureRecognizer(panGestureRecognizer)
        
        // Set Barriers
        barrierUpper.backgroundColor = UIColor.black
        barrierLeft.backgroundColor = UIColor.black
        barrierUpperRight.backgroundColor = UIColor.black
        barrierLowerRight.backgroundColor = UIColor.black
        barrierLower.backgroundColor = UIColor.black
        view.addSubview(barrierUpper)
        view.addSubview(barrierLeft)
        view.addSubview(barrierUpperRight)
        view.addSubview(barrierLowerRight)
        view.addSubview(barrierLower)
        
        //Set Collisions
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [playerBlock,puzzleBlockVertical])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "barrierUpper", for: UIBezierPath(rect: barrierUpper.frame))
        collision.addBoundary(withIdentifier: "barrierLeft", for: UIBezierPath(rect: barrierLeft.frame))
        collision.addBoundary(withIdentifier: "barrierUpperRight", for: UIBezierPath(rect: barrierUpperRight.frame))
        collision.addBoundary(withIdentifier: "barrierLowerRight", for: UIBezierPath(rect: barrierLowerRight.frame))
        collision.addBoundary(withIdentifier: "barrierLower", for: UIBezierPath(rect: barrierLower.frame))
        collision.addBoundary(withIdentifier: "puzzleBlockVertical", for: UIBezierPath(rect: puzzleBlockVertical.frame))
        animator.addBehavior(collision)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPlayerBlockPan(_ sender: UIPanGestureRecognizer) {
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
