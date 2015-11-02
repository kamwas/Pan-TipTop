//
//  CILRatio.m
//  ComposeImageLib
//
//  Created by Kamil Wasag on 27.09.2014.
//  Copyright (c) 2014 Figure-Eight. All rights reserved.
//

import UIKit

class CILRatio {
    
    var width:CGFloat = 0 {
        didSet{
            if width < 0 {
                width = 0
            }
        }
    }
    var height:CGFloat = 0 {
        didSet{
            if height < 0 {
                height = 0
            }
        }
    }
    
    static func  CILGetRatioFromImage(image:UIImage) -> CILRatio
    {
        return CILRatio(width: image.size.width, height: image.size.height);
    }
    
    static func CILGetRatioFromView(view:UIView) -> CILRatio
    {
        return CILRatio(width: view.frame.size.width, height:view.frame.size.height)
    }
    
    init(width:CGFloat, height:CGFloat)
    {
        self.width = width;
        self.height = height;
    }

    
    init(height:CGFloat)
    {
        
        self.width = 1.0;
        self.height = height;
        
    }
    
    init(width:CGFloat)
    {
        self.width = width;
        self.height = 1.0;
    }
    
    func ratioToFolatToCalculateWidth() ->CGFloat
    {
        return self.width/self.height
    }
    
    func ratioToFolatToCalculateHeight() -> CGFloat
    {
        return self.height/self.width
    }
    
    static func ratioWithWidth(width:CGFloat, height:CGFloat) -> CILRatio
    {
        return CILRatio(width: width, height: height)
    }
    
    static func ratioWithHeight(height:CGFloat) -> CILRatio
    {
        return CILRatio(height: height)
    }
    
    static func ratioWithWidth(width:CGFloat) -> CILRatio
    {
        return CILRatio(width: width)
    }

    var description:String{
        return "{w:" + self.width.description + ",h:" + self.height.description
    }
}

