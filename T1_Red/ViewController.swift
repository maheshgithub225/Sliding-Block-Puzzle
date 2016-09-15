//
//  ViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/8/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var originalPlayerBlockCenter: CGPoint!
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!

    let playerBlock = UIView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
    let barrier = UIView(frame: CGRect(x: 50, y: 200, width: 300, height: 2))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Blocks
        playerBlock.backgroundColor = UIColor.green
        view.addSubview(playerBlock)
        
        //Set Gesture Controls
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPlayerBlockPan(_:)))
        playerBlock.isUserInteractionEnabled = true
        playerBlock.addGestureRecognizer(panGestureRecognizer)
        
        // Set Barriers
        barrier.backgroundColor = UIColor.black
        view.addSubview(barrier)
        
        //Set Collisions
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [playerBlock])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "barrier", for: UIBezierPath(rect: barrier.frame))
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
            if (barrier.frame.intersects(playerBlock.frame)) {
                // Do something
                sender.isEnabled = false
                var unstuck: CGFloat = 0.00
                while(barrier.frame.intersects(playerBlock.frame)){
                    unstuck += 1.00
                    print("Unstuck val: \(unstuck)")
                    let new_y = originalPlayerBlockCenter.y + translation.y + unstuck
                    playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: new_y )
                }
                sender.isEnabled = true
            }else{
                playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: originalPlayerBlockCenter.y + translation.y)
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }
    

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

