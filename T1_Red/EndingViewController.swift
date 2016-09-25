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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */ 

}
