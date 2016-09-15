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
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    // Debug Code
    let DEBUG_OUTPUT = false
    let DEBUG_FREE_PLAYER = false
    // Blocks
    let playerBlock = UIView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
    let barrierUpper = UIView(frame: CGRect(x: 0, y: -300, width: 414, height: 500))
    let barrierLeft = UIView(frame: CGRect(x: -100, y: 200, width: 114, height: 736))
    let barrierRight = UIView(frame: CGRect(x: 400, y: 200, width: 414, height: 736))
    let barrierLower = UIView(frame: CGRect(x: 0, y: 636, width: 414, height: 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Blocks
        playerBlock.backgroundColor = UIColor.green
        view.addSubview(playerBlock)
        
        //Set Gesture Controls
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPlayerBlockPan(_:)))
        playerBlock.isUserInteractionEnabled = true
        playerBlock.addGestureRecognizer(panGestureRecognizer)
        
        // Set Barriers
        barrierUpper.backgroundColor = UIColor.black
        barrierLeft.backgroundColor = UIColor.blue
        barrierRight.backgroundColor = UIColor.red
        barrierLower.backgroundColor = UIColor.yellow
        view.addSubview(barrierUpper)
        view.addSubview(barrierLeft)
        view.addSubview(barrierRight)
        view.addSubview(barrierLower)
        
        //Set Collisions
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [playerBlock])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "barrierUpper", for: UIBezierPath(rect: barrierUpper.frame))
        collision.addBoundary(withIdentifier: "barrierLeft", for: UIBezierPath(rect: barrierLeft.frame))
        collision.addBoundary(withIdentifier: "barrierRight", for: UIBezierPath(rect: barrierRight.frame))
        collision.addBoundary(withIdentifier: "barrierLower", for: UIBezierPath(rect: barrierLower.frame))
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
            }else if(barrierRight.frame.intersects(playerBlock.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierRight.frame.intersects(playerBlock.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                    playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                }
                sender.isEnabled = true     // Enables Gesture
                
            }else{
                if(DEBUG_FREE_PLAYER){
                    playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x + translation.x, y: originalPlayerBlockCenter.y + translation.y)
                }else{
                    playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: originalPlayerBlockCenter.y + translation.y)
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
