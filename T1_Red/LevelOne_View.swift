//
//  LevelOne_View.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class LevelOne_View: UIView {

    let winBlock: UIImage? = UIImage(named:"green_button10.png")

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawWinBlock();
    }
    
    func drawWinBlock(){
        // Drawing code
        guard let winBlock = winBlock else{
            return
        }
        
        let p = CGPoint(
            x: (self.bounds.size.width - winBlock.size.width)/2,
            y: (self.bounds.size.height - winBlock.size.height)/2
        )
        winBlock.draw(at: p)
    }
}
