//
//  RandomNSTimeInterval.swift
//  pantiptop
//
//  Created by Kamil Wasag on 20.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import Foundation

extension NSTimeInterval
{
    public static func random() -> NSTimeInterval {
        return NSTimeInterval(arc4random()) / 0xFFFFFFFF
    }
    
    public static func random(min minimum: NSTimeInterval, max maximum: NSTimeInterval) -> NSTimeInterval {
        return NSTimeInterval.random() * (maximum - minimum) + minimum
    }
}