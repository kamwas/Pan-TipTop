//
//  WordPreviewCollectionCell.swift
//  pantiptop
//
//  Created by Kamil Wasag on 13.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class WordPreviewCollectionCell: UICollectionViewCell {
    var canAnimate = true
    @IBOutlet var dravingCanvas:UIView!
    @IBOutlet var ground:UIImageView!
    var images:Dictionary<String,UIImage>?
    var objectToDisplay:Array<WorldObject>? {
        didSet{
            self.animateWorld()
        }
    }
    
    func animateWorld(){
        if self.canAnimate{
            for object  in objectToDisplay! {
                let newImage:UIImageView = UIImageView(frame: object.frame)
                newImage.image = images![object.fileName]
                newImage.transform = CGAffineTransformMakeRotation(object.rotation)
                newImage.alpha = object.alpha
                
                
                switch DrawingType(rawValue: object.fileName.characters.split{$0 == "-"}.map{Int(String($0))!}[0])! {
                case .SkyNotMoveBlinking:
                    self.blinking(newImage)
                case .GroundFlying :
                    self.flyInRectBin(CGRect(x: 0.0, y: 300, width: self.frame.width, height: 160), imageToAnimate: newImage)
                case .SkyFlying:
                    self.flyInRectBin(CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 300), imageToAnimate: newImage)
                case .GroundMoving:
                    self.moveGround(newImage)
                case .WaterNotMovingBlinking:
                    self.blinking(newImage)
                case .WaterSwiming:
                    self.flyInRectBin(CGRect(x: 0.0, y: 540, width: self.frame.width, height: self.frame.height-530), imageToAnimate: newImage)
                default:
                    break
                }
                self.dravingCanvas.addSubview(newImage)
            }
        }
    }
    
    func moveGround(image:UIImageView){
        let number = Int(round(CGFloat.random(min: 0.0, max: 1.0)))
        let startPoint:CGPoint = CGPoint(x: number==0 ? -image.frame.width : self.frame.width + image.frame.width, y: self.ground.frame.origin.y-self.ground.frame.height+5)
        let endPoint:CGPoint = CGPoint(x: number==1 ? -image.frame.width : self.frame.width + image.frame.width, y: self.ground.frame.origin.y-self.ground.frame.height+5)
        if startPoint.x < endPoint.x {
            image.image = UIImage(CGImage: image.image!.CGImage!, scale:image.image!.scale, orientation: .UpMirrored)
        }else{
            image.image = UIImage(CGImage: image.image!.CGImage!, scale: image.image!.scale, orientation: .Up)
        }
        image.center = startPoint
        UIView.animateWithDuration(NSTimeInterval.random(min: 2, max: 6), delay: NSTimeInterval.random(min: 1, max: 3), options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            image.center = endPoint
            }) { (canGo:Bool) -> Void in
                if self.canAnimate {
                    self.moveGround(image)
                }
        }
    }
    
    func blinking(image:UIImageView){
        UIView.animateWithDuration(NSTimeInterval.random(min: 0.31, max: 1.0), delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            image.alpha = CGFloat.random(min: 0.1, max: 0.4)
            }) { (canGo:Bool) -> Void in
                if self.canAnimate {
                    UIView.animateWithDuration(NSTimeInterval.random(min: 0.3, max: 1), delay: 0.0, options: .CurveLinear, animations: { () -> Void in
                        image.alpha = 1.0
                        }, completion: { (recurency:Bool) -> Void in
                            if self.canAnimate {
                                self.blinking(image)
                            }
                    })
                }
        }
        
    }
    
    func flyInRectBin(rect:CGRect,imageToAnimate:UIImageView){
        let number = Int(round(CGFloat.random(min: 0.0, max: 1.0)))
        let startPoint:CGPoint = CGPoint(x: number==0 ? -imageToAnimate.frame.width : self.frame.width + imageToAnimate.frame.width, y: CGFloat.random(min: rect.origin.y, max: CGRectGetMaxY(rect)))
        let endPoint:CGPoint = CGPoint(x: number==1 ? -imageToAnimate.frame.width : self.frame.width + imageToAnimate.frame.width, y: CGFloat.random(min: rect.origin.y, max: CGRectGetMaxY(rect)))
        imageToAnimate.center = startPoint
        if startPoint.x < endPoint.x {
            imageToAnimate.image = UIImage(CGImage: imageToAnimate.image!.CGImage!, scale:imageToAnimate.image!.scale, orientation: .UpMirrored)
        }else{
            imageToAnimate.image = UIImage(CGImage: imageToAnimate.image!.CGImage!, scale:imageToAnimate.image!.scale, orientation: .Up)
        }
        if canAnimate {
            UIView.animateWithDuration(NSTimeInterval.random(min: 1, max: 6), delay: NSTimeInterval.random(min: 1, max: 4), options: .CurveEaseInOut, animations: { () -> Void in
                imageToAnimate.center = endPoint
                }) { (can:Bool) -> Void in
                    if self.canAnimate{
                        self.flyInRectBin(rect, imageToAnimate: imageToAnimate)
                    }
            }
        }
        
    }

    
}
