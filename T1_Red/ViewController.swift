//
//  ViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/8/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioplayer: AVAudioPlayer!
    @IBOutlet weak var catchme: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func catcha(_ sender: UIButton) {
        
        let path = Bundle.main.path(forResource: "loudgun.mp3", ofType: nil)
        let url = URL(fileURLWithPath: path!)
        
        do{
            let sound = try AVAudioPlayer(contentsOf: url)
            audioplayer = sound
            sound.play()
        }catch{
        }

        
        
        
    }
}

