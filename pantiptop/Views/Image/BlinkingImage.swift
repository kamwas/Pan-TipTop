//
//  BlinkingImage.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class BlinkingImage : UIImageView {

    var isBlinkImage:Bool = false {
        didSet{
            if self.isBlinkImage
            {
                self.blinkImage()
            }
        }
    }
    
    var blinkingTime:NSTimeInterval = 1
    var blinkingDeley:NSTimeInterval = 4
    
    func alphaToValue(alphaValue : CGFloat, inTime : NSTimeInterval, deleay: NSTimeInterval, comlpletionHandler: ((Bool)->Void)?)
    {
        UIView.animateWithDuration(inTime, delay: 0.0, options: .CurveLinear, animations: {
            self.alpha = alphaValue
            }, completion: comlpletionHandler)
    }
    
    private func blinkImage(){
        if self.isBlinkImage {
            self.alphaToValue(0.0, inTime: self.blinkingTime,deleay:self.blinkingDeley, comlpletionHandler: { (finished:Bool) in
                if finished
                {
                    self.alphaToValue(1.0, inTime: self.blinkingTime,deleay:0, comlpletionHandler: { (ended:Bool) in
                        if ended
                        {
                            if self.isBlinkImage
                            {
                                self.blinkImage()
                            }
                        }
                    })
                }
            })
        }
    }
}