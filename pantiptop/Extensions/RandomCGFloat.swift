//
//  RandomCGFloat.swift
//  pantiptop
//
//  Created by Kamil Wasag on 20.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import CoreGraphics

extension CGFloat
{
    public static func random() -> CGFloat {
        return CGFloat(arc4random() / 0xFFFFFFFF)
    }

    public static func random(min minimum: CGFloat, max maximum: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}