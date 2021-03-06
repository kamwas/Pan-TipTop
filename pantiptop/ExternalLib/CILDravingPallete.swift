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
            if let currentView = view as? CILBasicObject  {
                if currentView != sender {
                    currentView.enabled = false;
                }
            }
        }
    }
    
    func disableDrawingObjects()
    {
        for view in self.subviews {
            if let currentView = view as? CILBasicObject {
                currentView.enabled = false;
            }
        }
    }
    
    func disableSuperviewAndSubviewsWithSender(sender:UIView)
    {
        self.disableDrawingObjectsWithSender(sender)
        if let superV = self.superview! as? CILDravingPallete {
            superV.disableSuperviewAndSubviewsWithSender(self)
        }
    }
    
}
