//
//  CILBasicObject.m
//  ComposeImageLib
//
//  Created by Kamil Wasag on 27.09.2014.
//  Copyright (c) 2014 Figure-Eight. All rights reserved.
//

import UIKit

protocol CILBasicObjectDelegate {
    func elementEnabled(element:CILBasicObject)
}

class CILBasicObject:CILDravingPallete{
// MARK: - properies
    var delegate:CILBasicObjectDelegate?
    
    var ratio:CILRatio {
        if (self.imageView.image != nil) {
            return CILRatio.CILGetRatioFromImage(self.imageView.image!)
        }
        return CILRatio.CILGetRatioFromView(self);
    }
    
    var blockRatio:Bool = false
    var image:UIImage? = nil
    var imageMargin:CGFloat = 0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var rotationAngle:CGFloat {
        return self.valueForKeyPath("layer.transform.rotation.z") as! CGFloat
    }
    
    var enableHorizontalFlip:Bool = false
    var borderdDuringEditing:Bool = false
    var removeWhenCenterOut:Bool = false
    
    var imageBackgorundColor:UIColor {
        set(newValue){
            self.imageView.backgroundColor = newValue
        }
        get{
            return self.imageView.backgroundColor!
        }
    }
    
    lazy var imageView:UIImageView = {
        var tmp  = UIImageView(frame:self.bounds)
        self.addSubview(tmp)
        return tmp
    }()
    
    lazy var panGestureRecognizer:UIPanGestureRecognizer = {
        var tmp:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action:"panObject:");
        self.addGestureRecognizer(tmp)
        return tmp
    }()
    
     lazy var rotationGestureRecognizer:UIRotationGestureRecognizer = {
        var tmp = UIRotationGestureRecognizer(target: self, action:"rotateObject:")
        self.addGestureRecognizer(tmp)
        return tmp
    }()
    
    lazy var pinchGestureRecognizer:UIPinchGestureRecognizer = {
        var tmp:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self,action:"scaleObject:")
        self.addGestureRecognizer(tmp);
        return tmp;
    }()
    
    lazy var doubleTapGestureRecognizer:UITapGestureRecognizer = {
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action :"flipHorizontalObject:")
        tap.numberOfTapsRequired = 2;
        self.addGestureRecognizer(tap);
        return tap
    }()
    
    lazy var singleTapGestureRecognizer:UITapGestureRecognizer = {
        var tmp:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"touchObject:")
        tmp.numberOfTapsRequired = 1;
        self.addGestureRecognizer(tmp);
        return tmp
    }()
    
    override var frame: CGRect {
        didSet {
            self.imageView.frame = CILSubstractNumberFormRect(self.bounds, number: self.imageMargin)
        }
    }
    
    var enableVertivalFlip:Bool {
        set(newValue){
            self.doubleTapGestureRecognizer.enabled = newValue
        }
        get{
            return self.doubleTapGestureRecognizer.enabled
        }
    }
    
    var panningEnabled:Bool {
        set(newValue){
            self.panGestureRecognizer.enabled = newValue
        }
        get{
            return self.panGestureRecognizer.enabled
        }
    }
    var rotationEnabled:Bool {
        set(newValue){
            self.rotationGestureRecognizer.enabled = newValue
        }
        get{
            return self.rotationGestureRecognizer.enabled
        }
    }
    
    var scaleEnabled:Bool{
        set(newValue){
            self.pinchGestureRecognizer.enabled = newValue
        }
        get{
            return self.pinchGestureRecognizer.enabled
        }
    }
    
    var selectionEnabled:Bool{
        set(newValue){
            self.singleTapGestureRecognizer.enabled = newValue
        }
        get{
            return self.singleTapGestureRecognizer.enabled
        }
    }
    
    var enabled:Bool = false{
        didSet{
            self.rotationEnabled = enabled;
            self.panningEnabled = enabled;
            self.scaleEnabled = enabled;
            self.enableHorizontalFlip = enabled;
            self.enableVertivalFlip = enabled
            
            if (enabled) {
                self.selectionEnabled = enabled;
                self.disableSuperviewAndSubviewsWithSender(self);
                if (self.borderdDuringEditing) {
                    self.borderSize = 1
                    self.cornerCurveRadius = 13
                }
                self.delegate?.elementEnabled(self)
            }else{
                self.disableDrawingObjectsWithSender(self)
                self.borderSize = 0
                self.cornerCurveRadius = 0
                
            }
        }
    }
    
    var pinchPoint1:CGPoint? = nil
    var pinchPoint2:CGPoint? = nil
// MARK: - initializers
    init(frame:CGRect, image:UIImage)
    {
        super.init(frame: frame)
        self.imageMargin = 0;
        self.imageView.image = image;
        self.userInteractionEnabled = true;
        self.clipsToBounds = true;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame:CGRect, imagePattern:UIImage)
    {
        super.init(frame: frame)
        self.imageMargin = 0;
        self.imageView.backgroundColor = UIColor(patternImage:imagePattern)
        self.userInteractionEnabled = false;
        self.clipsToBounds = false;
    }
    
    init(frame:CGRect, adjustToImageRatio:UIImage)
    {
        super.init(frame: frame)
        self.imageMargin = 0
        self.blockRatio = true
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit;
        self.userInteractionEnabled = true;
        self.clipsToBounds = true;
        self.rectToRatio()
    }
    
//MARK: - gestture recognizers selectors
    func panObject(panGesture:UIPanGestureRecognizer)
    {
        let translatedPoint:CGPoint = panGesture.translationInView(self.superview!)
        if panGesture.state == UIGestureRecognizerState.Began {
            
        }else if(panGesture.state == UIGestureRecognizerState.Changed)
        {
            self.center = CGPointMake(self.center.x + translatedPoint.x, self.center.y + translatedPoint.y);
        }else{
            if (!CGRectContainsPoint(self.superview!.bounds, self.center) && self.removeWhenCenterOut) {
                self.removeFromSuperview()
            }
        }
        panGesture.setTranslation(CGPointZero, inView:self.superview)
    }
  
    func rotateObject(rotation:UIRotationGestureRecognizer)
    {
        let rotate:CGFloat = rotation.rotation;
        rotation.rotation = 0;
        self.transform = CGAffineTransformRotate(self.transform, rotate);
    }

    func touchObject(tapGesture:UITapGestureRecognizer)
    {
        self.superview!.bringSubviewToFront(self)
        self.enabled = true;
    }
   
    func scaleObject(pinchGesture:UIPinchGestureRecognizer){
        if pinchGesture.numberOfTouches() > 1 {
            
            if (pinchGesture.state == UIGestureRecognizerState.Began)
            {
                if (!self.blockRatio) {
                    self.pinchPoint1 = pinchGesture.locationOfTouch(0, inView:self.superview)
                    self.pinchPoint2 = pinchGesture.locationOfTouch(1, inView:self.superview)
                }
            }else{
                if (self.blockRatio) {
                    let transform:CGAffineTransform = self.transform;
                    self.transform = CGAffineTransformIdentity;
                    var newFrame:CGRect = self.frame;
                    newFrame.origin.x -= ((self.frame.size.width * pinchGesture.scale)-self.frame.size.width)/2;
                    newFrame.size.width += (self.frame.size.width * pinchGesture.scale)-self.frame.size.width;
                    newFrame.size.height = self.frame.size.width * self.ratio.ratioToFolatToCalculateHeight();
                    self.frame = newFrame;
                    self.transform = transform;
                    pinchGesture.scale = 1;
                }else{
                    let transform:CGAffineTransform = self.transform;
                    self.transform = CGAffineTransformIdentity;
                    
                    let point1:CGPoint = pinchGesture.locationOfTouch(0, inView:self.superview)
                    let point2:CGPoint = pinchGesture.locationOfTouch(1, inView:self.superview)
                    
                    let oldFrame:CGRect = CILRectFromPoints(self.pinchPoint1!, p2: self.pinchPoint2!);
                    let newFrame:CGRect = CILRectFromPoints(point1, p2: point2);
                    
                    var newFrameForView:CGRect = self.frame;
                    newFrameForView.origin.x += (newFrame.origin.x - oldFrame.origin.x);
                    newFrameForView.origin.y += (newFrame.origin.y - oldFrame.origin.y);
                    newFrameForView.size.height += (newFrame.size.height - oldFrame.size.height);
                    newFrameForView.size.width += (newFrame.size.width - oldFrame.size.width);
                    self.frame = newFrameForView;
                    self.pinchPoint1 = point1;
                    self.pinchPoint2 = point2;
                    self.transform = transform;
                }
                self.setNeedsDisplay()
            }
        }
    }
  
    func flipHorizontalObject(flipGesture:UITapGestureRecognizer){
        //for project purposes
        self.removeFromSuperview()
//        var flippedOrientation:UIImageOrientation
//        switch (self.imageView.image!.imageOrientation) {
//            case UIImageOrientation.Down: flippedOrientation = UIImageOrientation.DownMirrored; break;
//            case UIImageOrientation.UpMirrored: flippedOrientation = UIImageOrientation.Up; break;
//            default:flippedOrientation = UIImageOrientation.UpMirrored; break;
//        }
//        self.imageView.image = UIImage(CGImage:self.imageView.image!.CGImage, scale:self.imageView.image!.scale, orientation:flippedOrientation)
    }
    //MARK: - helpers
    func rectToRatio(){
        var newFrame:CGRect = self.frame;
        if (CGRectGetHeight(self.frame)>CGRectGetWidth(self.frame)) {
            newFrame.size.height = self.ratio.ratioToFolatToCalculateHeight() * CGRectGetWidth(self.frame)
        }else{
            newFrame.size.width = CGRectGetHeight(self.frame) * self.ratio.ratioToFolatToCalculateWidth();
        }
        self.frame = newFrame;
    }

}