//
//  ObjectToSave.swift
//  pantiptop
//
//  Created by Kamil Wasag on 13.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit


class WorldObject:NSObject{
    let alpha:CGFloat!
    let frame:CGRect!
    let fileName:String!
    let rotation:CGFloat!
    
    init(fileName:String, frame:CGRect, rotation:CGFloat, alpha:CGFloat){
        self.alpha = alpha
        self.frame = frame
        self.fileName = fileName
        self.rotation = rotation
    }
    
    required init(coder decoder: NSCoder) {
        self.alpha = CGFloat(decoder.decodeFloatForKey("alpha"))
        self.frame = decoder.decodeCGRectForKey("frame")
        self.fileName = decoder.decodeObjectForKey("fileName") as! String
        self.rotation = CGFloat(decoder.decodeFloatForKey("rotation"))
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeFloat(Float(self.alpha), forKey: "alpha")
        coder.encodeCGRect(self.frame, forKey: "frame")
        coder.encodeObject(self.fileName, forKey: "fileName")
        coder.encodeFloat(Float(self.rotation), forKey: "rotation")
    }
}