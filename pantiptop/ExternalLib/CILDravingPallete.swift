//
//  CILDravingPallete.m
//  ComposeImageLib
//
//  Created by Kamil Wasag on 29.09.2014.
//  Copyright (c) 2014 Figure-Eight. All rights reserved.
//



import UIKit

class CILDravingPallete : BorderedView {
    
    func disableDrawingObjectsWithSender(sender:UIView)
    {
        for view in self.subviews {
            if view.isMemberOfClass(CILBasicObject) {
                if view != sender {
                    (view as! CILBasicObject).enabled = false;
                }
            }
        }
    }
    
    func disableDrawingObjects()
    {
        for view in self.subviews {
            if view.isMemberOfClass(CILBasicObject) {
                    (view as! CILBasicObject).enabled = false;
            }
        }
    }
    
    func disableSuperviewAndSubviewsWithSender(sender:UIView)
    {
        self.disableDrawingObjectsWithSender(sender)
        if self.superview!.isKindOfClass(CILDravingPallete) {
            (self.superview as! CILDravingPallete ).disableSuperviewAndSubviewsWithSender(self)
        }
    }
    
}
