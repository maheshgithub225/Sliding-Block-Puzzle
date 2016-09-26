//
//  LoadViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import AVFoundation

class LoadViewController: UIViewController {

    var audioplayer: AVAudioPlayer!
    
    var score1: Int64 = 0
    var score2: Int64 = 0
    var score3: Int64 = 0
    
    var time1: TimeInterval!
    var time2: TimeInterval!
    var time3: TimeInterval!
    
    
    func getScore(scoreVal: Int) -> Int64{
        if(scoreVal == 1){
            return self.score1
        }else if(scoreVal == 2){
            return self.score2
        }else if(scoreVal == 3){
            return self.score3
        }
        return 0
    }
    
    func setScore(scoreVal: Int, points: Int64){
        if(scoreVal == 1){
            self.score1 = points
        }else if(scoreVal == 2){
            self.score2 = points
        }else if(scoreVal == 3){
            self.score3 = points
        }
    }
    
    func getTime(timeVal: TimeInterval) -> TimeInterval{
        if(timeVal == 1){
            return self.time1
        }else if(timeVal == 2){
            return self.time2
        }else if(timeVal == 3){
            return self.time3
        }
        return 0
    }
    
    func setTime(timeVal: Int, time: TimeInterval){
        if(timeVal == 1){
            self.time1 = time
        }else if(timeVal == 2){
            self.time2 = time
        }else if(timeVal == 3){
            self.time3 = time
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeSound()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            let menu =  self.storyboard?.instantiateViewController(withIdentifier: "MenuID") as! ViewController
            self.present(menu, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func ThemeSound() {
        let theme = Bundle.main.path(forResource: "retro crime music", ofType: "wav")
        let url = URL(fileURLWithPath: theme!)
        do{
            let themeSong = try AVAudioPlayer(contentsOf: url)
            audioplayer = themeSong
            audioplayer.numberOfLoops = -1
            audioplayer.volume = 0.25
            themeSong.play()
        }catch{
            
        }
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
var player = LoadViewController()
