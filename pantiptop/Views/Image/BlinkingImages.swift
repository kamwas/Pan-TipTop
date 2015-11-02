//
//  BlinkingImages.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class BlinkingImages: UIView {
    
    var minAnimationTime:NSTimeInterval = 2
    var maxAnimationTime:NSTimeInterval = 4

    var animate = false {
        didSet{
            if animate {
                self.setBlinkingImages(true)
            }else{
                self.setBlinkingImages(false)
            }
        }
    }

    override var alpha:CGFloat{
        didSet{
            if alpha==0{
                for imageView in self.subviews
                {
                    if imageView.isMemberOfClass(BlinkingImage.self){
                        (imageView as! BlinkingImage).alpha = alpha
                    }
                }
            }else{
                var viewIndex:NSTimeInterval = 0
                for imageView in self.subviews
                {
                    UIView.animateWithDuration(2.0, delay: viewIndex*2+0.5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                        (imageView as! BlinkingImage).alpha = self.alpha
                    }, completion: nil)
                    viewIndex++
                }
            }
        }
    }
    
    private func setBlinkingImages(blink:Bool)
    {
        for imageView in self.subviews
        {
            if imageView.isMemberOfClass(BlinkingImage.self){
                (imageView as! BlinkingImage).isBlinkImage = blink
            }
        }
    }
    
    var images:Array<UIImage?>  {
        set {
            var delay:NSTimeInterval = 2
            for image in newValue
            {
                let currentImageView:BlinkingImage! = BlinkingImage(frame: self.bounds)
                currentImageView.contentMode = UIViewContentMode.Right
                currentImageView.image = image;
                currentImageView.blinkingDeley = delay
                currentImageView.blinkingTime = NSTimeInterval.random(min: self.minAnimationTime, max: self.maxAnimationTime)
                self.addSubview(currentImageView)
                delay+=1.5
            }
        }
        get {
            return self.images
        }
    }
}
