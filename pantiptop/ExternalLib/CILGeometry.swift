//
//  CILGeometry.m
//  ComposeImageLib
//
//  Created by Kamil Wasag on 28.09.2014.
//  Copyright (c) 2014 Figure-Eight. All rights reserved.
//

import UIKit


func CILRectFromPoints(p1:CGPoint,  p2:CGPoint) -> CGRect
{
    return CGRect(x:min(p1.x, p2.x),
        y:min(p1.y, p2.y),
        width:max(p1.x, p2.x)-min(p1.x, p2.x),
        height:max(p1.y, p2.y)-min(p1.y, p2.y));
}

func CILSubstractNumberFormRect(rect:CGRect, number:CGFloat)->CGRect
{
    return CGRect(x: rect.origin.x+number,
        y: rect.origin.y+number,
        width: rect.size.width - 2*number,
        height: rect.size.height - 2*number)
}

func CILAddNumberToRect(rect:CGRect, number:CGFloat) -> CGRect
{
    return CILSubstractNumberFormRect(rect, number: -1*number);
}
