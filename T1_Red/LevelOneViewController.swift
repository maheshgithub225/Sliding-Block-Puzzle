//
//  LevelOneViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/15/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class LevelOneViewController: UIViewController {

    var LevelOneScore: Int64 = 0

    
    var originalPlayerBlockCenter: CGPoint!
    var originalPuzzleBlockCenterVertical: CGPoint!
    var originalPuzzleBlockCenterHorizontal: CGPoint!
    var orginalPuzzleBloackCenterOrange: CGPoint!
    
    var startPlayer: CGRect!
    var startPuzzleVert:CGRect!
    var startPuzzleHorizontal: CGRect!
    var startPuzzleOrange: CGRect!
    
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    // Debug Code
    let DEBUG_OUTPUT = false
    let DEBUG_FREE_PLAYER = false
    
    // Player Blocks
    //let playerBlock = UIView(frame: CGRect(x: 10, y: 400, width: 50, height: 50))
    // Puzzle Blocks
    //let puzzleBlockVertical = UIView(frame: CGRect(x: 200, y: 430, width: 50, height: 198))
    //let puzzleBlockHorizontal = UIView(frame: CGRect(x: 200, y: 200, width: 160, height: 50))
    //let puzzleBlockOrange = UIView(frame: CGRect(x:80, y: 200, width:50, height:150))
   // let sampleimage = UIImageView(frame: CGRect(x: 10, y: 400, width: 50, height: 50))
     
    // Barriers
    let barrierUpper = UIView(frame: CGRect(x: 0, y: -600, width: 414, height: 800))
    let barrierLeft = UIView(frame: CGRect(x: -1000, y: 200, width: 1014, height: 736))
    let barrierUpperRight = UIView(frame: CGRect(x: 400, y: 200, width: 1014, height: 190))
    let barrierLowerRight = UIView(frame: CGRect(x: 400, y: 460, width: 1014, height: 190))
    let barrierLower = UIView(frame: CGRect(x: 0, y: 636, width: 414, height: 800))
    

    @IBOutlet weak var TimerView: UILabel!
    
    @IBOutlet weak var puzzleBlockHorizontal: UIImageView!
    @IBOutlet weak var puzzleBlockOrange: UIImageView!
    @IBOutlet weak var puzzleBlockVertical: UIImageView!
    @IBOutlet weak var playerBlock: UIImageView!
    
    // Exit
    let exitBlock = UIView(frame: CGRect(x: 430, y: 380, width: 700, height: 80))
    
    //Alert
    let alertController = UIAlertController(title: "Clue1", message: "Clue1", preferredStyle: .alert)
    let NextClue = UIAlertAction(title: "Next Clue?", style: .destructive){(_) -> Void in
        
    }
    let Menu = UIAlertAction(title: "Menu", style: .destructive){
        (result : UIAlertAction)in debugPrint("Menu")
    }
    let Back = UIAlertAction(title: "Back", style: .destructive){
         (result : UIAlertAction)in debugPrint("Back")
        
    }
    
    var timeScoreMin: [String] = []
    var timeScoreSec: [String] = []
    
    var timeArrMin:[String] = []
    var timeArrSec:[String] = []
    
    
    var startTime = TimeInterval()
    
    var timer:Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeArrMin.insert("00", at: 0)
        timeArrSec.insert("00", at: 0)
        timeArrMin.insert("00", at: 1)
        timeArrSec.insert("00", at: 1)
        
        if (!timer.isValid) {
            let aSelector : Selector = #selector(LevelOneViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = Date.timeIntervalSinceReferenceDate
        }
        
        

        
        // Create Exit
        exitBlock.backgroundColor = UIColor.black
        view.addSubview(exitBlock)
        
        //Set Gesture Controls
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPlayerBlockPan(_:)))
        playerBlock.isUserInteractionEnabled = true
        playerBlock.addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPuzzleBlockPan(_:)))
        puzzleBlockVertical.isUserInteractionEnabled = true
        puzzleBlockVertical.addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPuzzleBlockPanBlue(_:)))
        puzzleBlockHorizontal.isUserInteractionEnabled = true
        puzzleBlockHorizontal.addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LevelOneViewController.didPuzzleBlockPanOrange(_:)))
        puzzleBlockOrange.isUserInteractionEnabled = true
        puzzleBlockOrange.addGestureRecognizer(panGestureRecognizer)
        
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
        
        startPlayer = playerBlock.frame
        startPuzzleVert = puzzleBlockVertical.frame
        startPuzzleHorizontal = puzzleBlockHorizontal.frame
        startPuzzleOrange = puzzleBlockOrange.frame
        
        
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
        collision.addBoundary(withIdentifier: "puzzleBlockOrange", for: UIBezierPath(rect: puzzleBlockOrange.frame))
        animator.addBehavior(collision)
        
        // Buttons
        let quitButton = UIButton(frame: CGRect(x: 20, y: 685, width: 95, height: 30))
        let resetButton = UIButton(frame: CGRect(x: 299, y: 685, width: 95, height: 30))
        
        resetButton.backgroundColor = UIColor.clear
        resetButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        resetButton.setTitle("Reset", for: UIControlState.normal)
        resetButton.addTarget(self, action: #selector(LevelOneViewController.Reset), for: UIControlEvents.touchUpInside)
        view.addSubview(resetButton)
        
        quitButton.backgroundColor = UIColor.clear
        quitButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        quitButton.setTitle("Quit", for: UIControlState.normal)
        quitButton.addTarget(self, action: #selector(LevelOneViewController.Quit), for: UIControlEvents.touchUpInside)
        view.addSubview(quitButton)

        
    }
    func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        TimerView.text = "\(strMinutes):\(strSeconds)"
        timeScoreMin.append(strMinutes)
        timeScoreSec.append(strSeconds)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressed(sender: UIButton!) {
        let nextLevel =  super.self().storyboard?.instantiateViewController(withIdentifier: "Level2") as! ViewController
        super.self().present(nextLevel, animated: true, completion: nil)
    }
    
    @IBAction func didPlayerBlockPan(_ sender: UIPanGestureRecognizer) {
        //let point = sender.location(in: view)
        let translation = sender.translation(in: view)

        if sender.state == UIGestureRecognizerState.began {
            LevelOneScore = LevelOneScore + 1
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
            }else if(puzzleBlockOrange.frame.intersects(playerBlock.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockOrange.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                        playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                    }
                }else{
                    while(puzzleBlockOrange.frame.intersects(playerBlock.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                        playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y )
                    }
                }
                sender.isEnabled = true
            }else if(exitBlock.frame.intersects(playerBlock.frame)){
                sender.isEnabled = false
                sender.isEnabled = true
                alertController.addAction(UIAlertAction(title:"Next Clue", style: .default, handler: {action in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    // Change the identifier to the correct identifier of the viewcontroller on the storyboard and change the viewcontroller to the correct view controller
                    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Level2") as! LevelTwoViewController
                    self.present(resultViewController, animated:true, completion:nil)
                }))
                alertController.addAction(UIAlertAction(title:"Menu", style: .default, handler: {action in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    // Change the identifier to the correct identifier of the viewcontroller on the storyboard and change the viewcontroller to the correct view controller
                    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MenuID") as! ViewController
                    self.present(resultViewController, animated:true, completion:nil)
                }))
                
                timer.invalidate()
                timeArrMin.append(timeScoreMin.last!)
                timeArrSec.append(timeScoreSec.last!)
                
                //displayYourScoreTime.text = "Your Time: \(timeArrMin.last!)m:\(timeArrSec.last!)s"
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                if(DEBUG_FREE_PLAYER){
                    playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x + translation.x, y: originalPlayerBlockCenter.y + translation.y)
                }else{
                    playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x + translation.x , y: originalPlayerBlockCenter.y)
                }
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            var unstuck: CGFloat = 0.00
            while(barrierUpper.frame.intersects(playerBlock.frame)){
                unstuck += 0.01
                if(DEBUG_OUTPUT){
                    print("Unstuck val: \(unstuck)")
                }
                let new_y = originalPlayerBlockCenter.y + translation.y + unstuck
                playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: new_y )
            }
            unstuck = 0.00
            while(barrierLower.frame.intersects(playerBlock.frame)){
                unstuck += 0.01
                if(DEBUG_OUTPUT){
                    print("Unstuck val: \(unstuck)")
                }
                let new_y = originalPlayerBlockCenter.y + translation.y - unstuck
                playerBlock.center = CGPoint(x: originalPlayerBlockCenter.x, y: new_y )
            }
            unstuck = 0.00
            while(barrierLeft.frame.intersects(playerBlock.frame)){
                unstuck += 0.01
                if(DEBUG_OUTPUT){
                    print("Unstuck val: \(unstuck)")
                }
                let new_x = originalPlayerBlockCenter.x + translation.x + unstuck
                playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y)
            }
            unstuck = 0.00
            while(barrierLowerRight.frame.intersects(playerBlock.frame)){
                unstuck += 0.01
                if(DEBUG_OUTPUT){
                    print("Unstuck val: \(unstuck)")
                }
                let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y)
            }
            unstuck = 0.00
            while(barrierLowerRight.frame.intersects(playerBlock.frame)){
                unstuck += 0.01
                if(DEBUG_OUTPUT){
                    print("Unstuck val: \(unstuck)")
                }
                let new_x = originalPlayerBlockCenter.x + translation.x - unstuck
                playerBlock.center = CGPoint(x: new_x, y: originalPlayerBlockCenter.y)
            }
            unstuck = 0.00
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
    @IBAction func didPuzzleBlockPanBlue(_ sender: UIPanGestureRecognizer) {
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
                    let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                    puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterVertical.y )
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
            }else if(puzzleBlockOrange.frame.intersects(puzzleBlockHorizontal.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.x
                if(translationDirection >= 0){
                    while(puzzleBlockOrange.frame.intersects(puzzleBlockHorizontal.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_x = originalPuzzleBlockCenterHorizontal.x + translation.x - unstuck
                        puzzleBlockHorizontal.center = CGPoint(x: new_x, y: originalPuzzleBlockCenterHorizontal.y )
                    }
                }else{
                    while(puzzleBlockOrange.frame.intersects(puzzleBlockHorizontal.frame)){
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
            
        }
    }
    @IBAction func didPuzzleBlockPanOrange(_ sender: UIPanGestureRecognizer) {
        //var point = sender.location(in: view)
        //var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            orginalPuzzleBloackCenterOrange = puzzleBlockOrange.center
        } else if sender.state == UIGestureRecognizerState.changed {
            if (barrierUpper.frame.intersects(puzzleBlockOrange.frame)) {     // Block has intersected with boundry, get unstuck.
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpper.frame.intersects(puzzleBlockOrange.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = orginalPuzzleBloackCenterOrange.y + translation.y + unstuck
                    puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLower.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLower.frame.intersects(puzzleBlockOrange.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_y = orginalPuzzleBloackCenterOrange.y + translation.y - unstuck
                    puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLeft.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLeft.frame.intersects(puzzleBlockOrange.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBloackCenterOrange.x + translation.x + unstuck
                    puzzleBlockOrange.center = CGPoint(x: new_x, y: orginalPuzzleBloackCenterOrange.y)
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierUpperRight.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierUpperRight.frame.intersects(puzzleBlockOrange.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBloackCenterOrange.x + translation.x - unstuck
                    puzzleBlockOrange.center = CGPoint(x: new_x, y: orginalPuzzleBloackCenterOrange.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(barrierLowerRight.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false    //Disables Gestures
                var unstuck: CGFloat = 0.00
                while(barrierLowerRight.frame.intersects(puzzleBlockOrange.frame)){
                    unstuck += 0.01
                    if(DEBUG_OUTPUT){
                        print("Unstuck val: \(unstuck)")
                    }
                    let new_x = orginalPuzzleBloackCenterOrange.x + translation.x - unstuck
                    puzzleBlockOrange.center = CGPoint(x: new_x, y: orginalPuzzleBloackCenterOrange.y )
                }
                sender.isEnabled = true     // Enables Gesture
            }else if(playerBlock.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(playerBlock.frame.intersects(puzzleBlockOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBloackCenterOrange.y + translation.y - unstuck
                        puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                    }
                }else{
                    while(playerBlock.frame.intersects(puzzleBlockOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBloackCenterOrange.y + translation.y + unstuck
                        puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else if(puzzleBlockHorizontal.frame.intersects(puzzleBlockOrange.frame)){
                sender.isEnabled = false //Disables Gesture
                var unstuck: CGFloat = 0.00
                let translationDirection = translation.y
                if(translationDirection >= 0){
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuc val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBloackCenterOrange.y + translation.y - unstuck
                        puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                    }
                }else{
                    while(puzzleBlockHorizontal.frame.intersects(puzzleBlockOrange.frame)){
                        unstuck += 0.01
                        if(DEBUG_OUTPUT){
                            print("Unstuck val: \(unstuck)")
                        }
                        let new_y = orginalPuzzleBloackCenterOrange.y + translation.y + unstuck
                        puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: new_y )
                    }
                }
                sender.isEnabled = true
            }else{
                if(DEBUG_FREE_PLAYER){
                    puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x + translation.x, y: orginalPuzzleBloackCenterOrange.y + translation.y)
                }else{
                    puzzleBlockOrange.center = CGPoint(x: orginalPuzzleBloackCenterOrange.x, y: orginalPuzzleBloackCenterOrange.y + translation.y)
                }
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            //Nothing!
        }
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    

    func Reset() {
        LevelOneScore = 0
        playerBlock.frame = startPlayer
        puzzleBlockOrange.frame = startPuzzleOrange
        puzzleBlockHorizontal.frame = startPuzzleHorizontal
        puzzleBlockVertical.frame = startPuzzleVert
        
    }
    
    func Quit(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        // Change the identifier to the correct identifier of the viewcontroller on the storyboard and change the viewcontroller to the correct view controller
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MenuID") as! ViewController
        self.present(resultViewController, animated:true, completion:nil)
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


