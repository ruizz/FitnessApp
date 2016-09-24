//
//  CounterView.swift
//  FitnessApp
//
//  Created by Ruiz Akpan on 9/23/16.
//  Copyright © 2016 helloruiz. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let pi: CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {

    // Inspectables
    @IBInspectable var counter: Int = 0 {
        didSet {
            if (self.counter < 0) {
                self.counter = 0
                
            } else if (self.counter > NoOfGlasses) {
                self.counter = NoOfGlasses
                
            }
            setNeedsDisplay()
            
        }
        
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x:bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width / 2, bounds.height / 2)
        
        // arcWidth will basically be the 25% of the bounds
        let arcWidth: CGFloat = radius / 2
        let outlineWidth: CGFloat = 6
        
        // Fun fact: The angle starts at the far right of the circle, not the top.
        // Background to denote glass-drinking quota
        let startAngle: CGFloat = pi - pi / 4
        let endAngle: CGFloat = pi / 4
        let path = UIBezierPath(arcCenter: center, radius: radius - arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        self.counterColor.setStroke()
        path.stroke()
        
        // Border to denote glass-drinking profress
        if (counter > 0 && counter <= NoOfGlasses) {
            // This is just from eyeballing
            let arcLength = pi + (pi / 2)
            let arcLengthPerGlass = arcLength / CGFloat(NoOfGlasses)
            let outlineEndAngle = startAngle + (arcLengthPerGlass * CGFloat(counter))
            
            // Outer and Inner
            let outlinePath = UIBezierPath(arcCenter: center, radius: radius - (outlineWidth / 2), startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
            outlinePath.addArc(withCenter: center, radius: radius - arcWidth + (outlineWidth / 2), startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
            outlinePath.close()
            self.outlineColor.setStroke()
            outlinePath.lineWidth = outlineWidth
            outlinePath.stroke()
            
        }
        
    }

}
