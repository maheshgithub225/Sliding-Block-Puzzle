//
//  load.swift
//  mess
//
//  Created by Bryan Reynolds on 9/19/16.
//  Copyright © 2016 Bryan Reynolds. All rights reserved.
//

import UIKit

class load: UIView {

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    let capture=UIImage(named: "blackscreen.bmp")
    let capturetwo=UIImage(named: "badge.png")
    
    
    override func draw(_ rect: CGRect) {
        // Draws selfie below_________________
        guard let capture=capture else{
            return
        }
        guard let capturetwo=capturetwo else{
            return
        }
        
        guard let context=UIGraphicsGetCurrentContext() else {return}
        
        //310-320, 510-550    2.97      2
        let p = CGRect(x:0,y:0,width:capture.size.width/1.1,height:capture.size.height*1.38)
        let ptwo = CGPoint(x:(self.bounds.size.width-capturetwo.size.width)/2,y:(self.bounds.height-capturetwo.size.height)/2)
        
        
        capture.draw(in: p)
        capturetwo.draw(at: ptwo)
        //____________________________________
        
    }
    
    



}
