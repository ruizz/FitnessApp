//
//  GraphView.swift
//  FitnessApp
//
//  Created by Ruiz Akpan on 9/24/16.
//  Copyright © 2016 helloruiz. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

    // Inspectables
    
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    // Variables
    
    // Sample data
    var graphPoints:[Int] = [4, 0, 6, 4, 5, 8, 3]
    private let xMargin:CGFloat = 16
    private let yMargin:CGFloat = 40
    
    override func draw(_ rect: CGRect) {
        // Get the context
        guard let context = UIGraphicsGetCurrentContext() else {
            return
            
        }
        
        // Round the corners
        UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: rect.width * 0.04, height: rect.height * 0.04)).addClip()
        
        // Add gradient
        let backgroundColors = [startColor.cgColor, endColor.cgColor]
        let graphColors = [self.lighter(startColor).cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        guard let backgroundGradient = CGGradient(colorsSpace: colorSpace, colors: backgroundColors as CFArray, locations: colorLocations), let graphGradient = CGGradient(colorsSpace: colorSpace, colors: graphColors as CFArray, locations: colorLocations) else {
            return
            
        }
        
        context.drawLinearGradient(backgroundGradient, start: CGPoint.zero, end: CGPoint(x:0, y:self.bounds.height), options: CGGradientDrawingOptions(rawValue: 0))
        
        // Graph line
        UIColor.white.setFill()
        UIColor.white.setStroke()
        var highestGraphPoint = rect.height
        
        let graphPath = UIBezierPath()
        graphPath.move(to: getPoint(index: 0, rect: rect))
        for i in 1..<graphPoints.count {
            let point = getPoint(index: i, rect: rect)
            highestGraphPoint = min(highestGraphPoint, point.y)
            graphPath.addLine(to: point)
            
        }
        graphPath.stroke()
        
        // Graph clipping and gradient
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLine(to: CGPoint(x: rect.width - 16, y: rect.height - self.yMargin))
        clippingPath.addLine(to: CGPoint(x: 16, y: rect.height - self.yMargin))
        clippingPath.close()
        
        // Save the current state before adding the clipping mask. Restore the state to remove the mask.
        context.saveGState()
        clippingPath.addClip()
        context.drawLinearGradient(graphGradient, start: CGPoint(x: 0, y: highestGraphPoint), end: CGPoint(x:0, y:self.bounds.height), options: CGGradientDrawingOptions(rawValue: 0))
        context.restoreGState()
        
        // Graph line
        graphPath.lineWidth = 2
        graphPath.stroke()
        
        // Graph dots
        let dotSize: CGFloat = 7.0
        for i in 0..<graphPoints.count {
            var point = getPoint(index: i, rect: rect)
            point.x -= dotSize / 2
            point.y -= dotSize / 2
            
            let circle = UIBezierPath.init(ovalIn: CGRect(origin: point, size: CGSize(width: dotSize, height: dotSize)))
            circle.fill()
            
        }
        
        // Horizontal lines
        let linePath = UIBezierPath()
        var y:CGFloat = self.yMargin
        for _ in 0 ... NoOfGlasses {
            linePath.move(to: CGPoint(x: self.xMargin, y: y))
            linePath.addLine(to: CGPoint(x: rect.width - self.xMargin, y: y))
            let graphHeight = rect.height - CGFloat(self.yMargin * 2)
            let pointSpacing = graphHeight / CGFloat(max(NoOfGlasses, 1))
            y += pointSpacing
            
        }
        UIColor(white: 1.0, alpha: 0.3).setStroke()
        linePath.stroke()
        
    }
    
    func lighter(_ color: UIColor) -> UIColor{
        var r: CGFloat = 0, g: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0
        if (color.getRed(&r, green: &g, blue: &b, alpha: &a)) {
            return UIColor(red: r + 0.1, green: g + 0.1, blue: b + 0.1, alpha: a)
            
        } else {
            return color
            
        }
        
    }
    
    func getPoint(index: Int, rect: CGRect) -> CGPoint {
        var x:CGFloat = self.xMargin
        var y:CGFloat = rect.height - self.yMargin
        if (index >= 1) {
            let graphWidth = rect.width - CGFloat(self.xMargin * 2)
            var pointSpacing = graphWidth / CGFloat(max(graphPoints.count - 1, 1))
            pointSpacing *= CGFloat(index)
            x += pointSpacing
            
        }
        if (graphPoints[index] >= 1) {
            let graphHeight = rect.height - CGFloat(self.yMargin * 2)
            var pointSpacing = graphHeight / CGFloat(max(NoOfGlasses, 1))
            pointSpacing *= CGFloat(graphPoints[index])
            y -= pointSpacing
            
        }
        return CGPoint(x: x, y: y)
        
    }
    
}
