//
//  DrawingView.swift
//  pantiptop
//
//  Created by Kamil Wasag on 03.06.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

@IBDesignable
class DrawingView: UIView {
    
    private var lastPoint : CGPoint! = CGPointZero
    private var mouseSwiped = false
    private var tmpImageView : UIImageView!
    private lazy var backgroundImageView: UIImageView? = {
        let imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        return imageView
        }()
    
    var currentColor : UIColor = UIColor.whiteColor()
    var lineWidth : CGFloat = 4 
    
    var backgroundImage:UIImage?{
        get{
            return self.backgroundImageView?.image
        }
        set{
            self.backgroundImageView?.image = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupInit()
    }
    
    func setupInit(){
        tmpImageView = UIImageView(frame: self.bounds)
        addSubview(tmpImageView)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mouseSwiped = false
        lastPoint = touches.first?.locationInView(self);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mouseSwiped = true
        let currentPoint = touches.first?.locationInView(self);
        UIGraphicsBeginImageContext(self.bounds.size)
        self.tmpImageView.image?.drawInRect(self.bounds)
        if (currentPoint != nil) {
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint!.x, currentPoint!.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), .Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth)
            CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.currentColor.CGColor)
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(),self.currentColor == UIColor.clearColor() ? .Clear : .Normal)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.tmpImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let curveRadius:CGFloat = 15
        let bezierLineWidth:CGFloat = 1
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPointMake(bezierLineWidth, curveRadius))
        bezierPath.addCurveToPoint(CGPointMake(curveRadius, bezierLineWidth),
            controlPoint1: CGPointMake(bezierLineWidth, curveRadius),
            controlPoint2: CGPointMake(curveRadius, curveRadius))
        bezierPath.addLineToPoint(CGPoint(x: self.bounds.width-curveRadius, y: bezierLineWidth))
        bezierPath.addCurveToPoint(CGPoint(x: self.bounds.width-bezierLineWidth, y: curveRadius),
            controlPoint1: CGPoint(x: self.bounds.width-curveRadius, y: bezierLineWidth),
            controlPoint2: CGPoint(x: self.bounds.width-curveRadius, y: curveRadius))
        bezierPath.addLineToPoint(CGPoint(x: self.bounds.width-bezierLineWidth, y: self.bounds.height-curveRadius))
        bezierPath.addCurveToPoint(CGPoint(x: self.bounds.width-curveRadius, y: self.bounds.height-bezierLineWidth),
            controlPoint1: CGPoint(x: self.bounds.width-bezierLineWidth, y: self.bounds.height-curveRadius),
            controlPoint2: CGPoint(x: self.bounds.width-curveRadius, y: self.bounds.height-curveRadius))
        bezierPath.addLineToPoint(CGPoint(x: curveRadius, y: self.bounds.height-bezierLineWidth))
        bezierPath.addCurveToPoint(CGPoint(x: bezierLineWidth, y: self.bounds.height-curveRadius),
            controlPoint1: CGPoint(x: curveRadius, y: self.bounds.height-bezierLineWidth),
            controlPoint2: CGPoint(x: curveRadius, y: self.bounds.height-curveRadius))
        
        
        bezierPath.closePath()
        bezierPath.lineWidth = bezierLineWidth
        UIColor.whiteColor().setStroke()
        bezierPath.stroke()
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.CGPath
        self.tmpImageView.layer.mask = shapeLayer
        

        self.layer.mask = shapeLayer
    }
    
    func reset()
    {
        self.tmpImageView.image = nil
    }
    
    func getImage()->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.tmpImageView.bounds.size, false, 0.0)
        self.tmpImageView.drawRect(CGRect(x: 0, y: 0, width: self.tmpImageView.frame.size.width, height: self.tmpImageView.frame.size.height))
        let imageToRet:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageToRet
    }
}
