//
//  PTTPopUpContainer.swift
//  pantiptop
//
//  Created by Kamil Wasag on 09.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class PTTPopUpContainer: BorderedView {
     static let sharedContainer:PTTPopUpContainer = {
        let popup = PTTPopUpContainer(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        popup.clipsToBounds = true
        popup.alpha = 0.0
        return popup
    }()
    private static let curveRadius:CGFloat = 15
    private static let bezierLineWidth:CGFloat = 1
    private static let mainWindow:UIWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window!
    
    var isVisible:Bool {
        return self.alpha == 0.0 ? false: true
    }
    
    var insideView:UIView? {
        didSet{
            for view in self.subviews {
                view.removeFromSuperview()
            }
            if insideView != nil {
                let newFrame:CGRect = CGRect(x: 0,
                    y: 0,
                    width: insideView!.frame.width + 3*PTTPopUpContainer.curveRadius,
                    height: insideView!.frame.height + 3*PTTPopUpContainer.curveRadius)
                self.frame = newFrame
                self.insideView!.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
                self.addSubview(insideView!)
                self.setNeedsDisplay()
            }
        }
    }
    
    private static func showWithCompletion(completion:((Bool) -> Void)?){
        PTTPopUpContainer.sharedContainer.alpha = 0.0
        mainWindow.addSubview(PTTPopUpContainer.sharedContainer)
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            PTTPopUpContainer.sharedContainer.alpha = 1.0
        }, completion: completion)
    }
    
    static func show(atPoint:CGPoint,delay:NSTimeInterval){
        PTTPopUpContainer.sharedContainer.center = atPoint
        showWithCompletion { (Bool) -> Void in
            self.dismiss(delay,completionBlock: nil)
        }
    }
    
    static func show(){
        showWithCompletion(nil)
    }
    
    static func show(rect:CGRect){
        PTTPopUpContainer.sharedContainer.frame = rect
        showWithCompletion(nil)
    }
    
    
    private static func dismiss(delay:NSTimeInterval, completionBlock:(()->Void)?){
        UIView.animateWithDuration(1, delay: delay, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            PTTPopUpContainer.sharedContainer.alpha = 0.0
            }) { (Bool) -> Void in
                PTTPopUpContainer.sharedContainer.removeFromSuperview()
                if (completionBlock != nil) {
                    completionBlock!()
                }
        }
    }
    
    static func dismiss(afterDelay delay:NSTimeInterval, completionBlock:()->Void)
    {
        dismiss(delay, completionBlock: completionBlock)
    }
    
    
    static func dismiss(completionBlock:()->Void){
        dismiss(0,completionBlock: completionBlock)
    }
    
    static func dismiss(){
        dismiss(0, completionBlock: nil)
    }

    
    static func showAtPoint(atPoint:CGPoint){
        PTTPopUpContainer.sharedContainer.center = atPoint
        show()
    }
}

