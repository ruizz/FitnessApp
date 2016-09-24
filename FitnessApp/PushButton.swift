//
//  PushButton.swift
//  FitnessApp
//
//  Created by Ruiz Akpan on 9/23/16.
//  Copyright © 2016 helloruiz. All rights reserved.
//

import UIKit

@IBDesignable class PushButton: UIButton {
    
    // Inspectables
    @IBInspectable var buttonColor: UIColor = UIColor.gray
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        buttonColor.setFill()
        path.fill()
        
        let lineWidth = CGFloat(3.0)
        let lineLength = bounds.width * 0.6
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = lineWidth
        
        // Horizontal
        var plusPoint = CGPoint()
        plusPoint.x = (bounds.width / 2) - (lineLength / 2)
        plusPoint.y = bounds.height / 2
        plusPath.move(to: plusPoint)
        
        plusPoint.x = (bounds.width / 2) + (lineLength / 2)
        plusPath.addLine(to: plusPoint)
        
        // Vertical
        if (self.isAddButton) {
            plusPoint.x = bounds.width / 2
            plusPoint.y = (bounds.height / 2) - (lineLength / 2)
            plusPath.move(to: plusPoint)
            
            plusPoint.y = (bounds.height / 2) + (lineLength / 2)
            plusPath.addLine(to: plusPoint)
            
        }
        
        UIColor.white.setStroke()
        plusPath.stroke()
        
    }
 

}
