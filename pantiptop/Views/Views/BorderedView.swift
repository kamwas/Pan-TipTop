//
//  DorderedView.swift
//  pantiptop
//
//  Created by Kamil Wasag on 10.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedView: UIView {
    
    @IBInspectable var borderColor:UIColor = UIColor.clearColor() {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderSize:CGFloat = 0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerCurveRadius:CGFloat = 0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if self.borderSize > 0{
            let bezierPath = UIBezierPath()
            
            bezierPath.moveToPoint(CGPointMake(0, self.cornerCurveRadius))
            bezierPath.addCurveToPoint(CGPointMake(self.cornerCurveRadius, 0),
                controlPoint1: CGPointMake(0, self.cornerCurveRadius),
                controlPoint2: CGPointMake(self.cornerCurveRadius, self.cornerCurveRadius))
            bezierPath.addLineToPoint(CGPoint(x: self.bounds.width-self.cornerCurveRadius, y: 0))
            bezierPath.addCurveToPoint(CGPoint(x: self.bounds.width, y: self.cornerCurveRadius),
                controlPoint1: CGPoint(x: self.bounds.width-self.cornerCurveRadius, y: 0),
                controlPoint2: CGPoint(x: self.bounds.width-self.cornerCurveRadius, y: self.cornerCurveRadius))
            bezierPath.addLineToPoint(CGPoint(x: self.bounds.width, y: self.bounds.height-self.cornerCurveRadius))
            bezierPath.addCurveToPoint(CGPoint(x: self.bounds.width-self.cornerCurveRadius, y: self.bounds.height),
                controlPoint1: CGPoint(x: self.bounds.width, y: self.bounds.height-self.cornerCurveRadius),
                controlPoint2: CGPoint(x: self.bounds.width-self.cornerCurveRadius, y: self.bounds.height-self.cornerCurveRadius))
            bezierPath.addLineToPoint(CGPoint(x: self.cornerCurveRadius, y: self.bounds.height))
            bezierPath.addCurveToPoint(CGPoint(x: self.borderSize, y: self.bounds.height-self.cornerCurveRadius),
                controlPoint1: CGPoint(x: self.cornerCurveRadius, y: self.bounds.height),
                controlPoint2: CGPoint(x: self.cornerCurveRadius, y: self.bounds.height-self.cornerCurveRadius))
            bezierPath.closePath()
            
            bezierPath.lineWidth = self.borderSize
            self.borderColor.setStroke()
            bezierPath.stroke()
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = self.bounds
            shapeLayer.path = bezierPath.CGPath
            self.layer.mask = shapeLayer
        }
    }
    

    
}
