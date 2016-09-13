//
//  Horizontal_Block.swift
//  T1_Red
//
//  Created by Johnathan Taylor Sutton on 9/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class Horizontal_Block: UIButton {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.green.setFill()
        path.fill()
    }
 
}
