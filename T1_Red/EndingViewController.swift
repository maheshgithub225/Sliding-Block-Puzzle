//
//  EndingViewController.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var timeBonus = 0
        if(Int(player.getTime(timeVal: 1)/60.0) <= 5){
            timeBonus = 5 - Int(player.getTime(timeVal: 1)/60.0)
        }
        if(Int(player.getTime(timeVal: 2)/60.0) <= 5){
            timeBonus = 5 - Int(player.getTime(timeVal: 2)/60.0)
        }
        if(Int(player.getTime(timeVal: 3)/60.0) <= 5){
            timeBonus = 5 - Int(player.getTime(timeVal: 3)/60.0)
        }
        
        var scoreWithPar = 0
        if((1000 + (4 - Int(player.getScore(scoreVal: 1)))) > 0){
            scoreWithPar = scoreWithPar + (1000 + (4 - Int(player.getScore(scoreVal: 1))))
        }else{
            scoreWithPar = 0
        }
        if((1000 + (6 - Int(player.getScore(scoreVal: 2)))) > 0){
            scoreWithPar = scoreWithPar + (1000 + (6 - Int(player.getScore(scoreVal: 2))))
        }else{
            scoreWithPar = scoreWithPar + 0
        }
        if((1000 + (9 - Int(player.getScore(scoreVal: 3)))) > 0){
            scoreWithPar = scoreWithPar + (1000 + (9 - Int(player.getScore(scoreVal: 3))))
        }else{
            scoreWithPar = scoreWithPar + 0
        }
        
        
        let score = scoreWithPar + Int64(timeBonus)
        total.text = "Score:  \(score)"
        
        
        
        
    }
    @IBOutlet weak var ImageFinal: UIImageView!
    @IBAction func buttonImage(_ sender: AnyObject) {
        ImageFinal.image = #imageLiteral(resourceName: "perp.png")
        sender.setTitle(" ", for: UIControlState.normal)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var total: UILabel!
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */ 

}
