//
//  Splash.swift
//  mess
//
//  Created by Bryan Reynolds on 9/15/16.
//  Copyright © 2016 Bryan Reynolds. All rights reserved.
//

import UIKit

class Splash: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

 let capture=UIImage(named: "cs1cropped.jpg")
    let capturetwo=UIImage(named: "logot.png")


override func draw(_ rect: CGRect) {
    // Draws selfie below_________________
    guard let capture=capture else{
        return
    }
    guard let capturetwo=capturetwo else{
        return
    }
    
    guard UIGraphicsGetCurrentContext() != nil else {return}
    
    //310-320, 510-550    2.97      2
    let p = CGRect(x:0,y:0,width:capture.size.width/1.1,height:capture.size.height*1.38)
   let ptwo = CGRect(x:50,y:0,width:(capture.size.width),height:capturetwo.size.height/1.73)

   
    capture.draw(in: p)
     capturetwo.draw(in: ptwo)
    //____________________________________
    
}




}
