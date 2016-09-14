//
//  ViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/8/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var originalWinBlockCenter: CGPoint!

    @IBOutlet var winBlock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didWinBlockPan(_:)))
        winBlock.isUserInteractionEnabled = true
        winBlock.addGestureRecognizer(panGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didWinBlockPan(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalWinBlockCenter = winBlock.center
        } else if sender.state == UIGestureRecognizerState.changed {
            winBlock.center = CGPoint(x: originalWinBlockCenter.x, y: originalWinBlockCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
        }
    }
    

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

