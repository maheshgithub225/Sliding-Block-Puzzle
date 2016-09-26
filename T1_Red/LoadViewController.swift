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
