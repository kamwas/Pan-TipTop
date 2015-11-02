//
//  Storage.swift
//  Pan Tip Top
//
//  Created by Kamil Wasag on 02.11.2015.
//  Copyright © 2015 Kamil Wasag. All rights reserved.
//

import Foundation

class Storage {
    static let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    static func filesForExtension(exitension:String) -> Array<String>{
        return (NSFileManager().enumeratorAtPath(Storage.documentsDirectory)?.allObjects as! Array<String>).filter{$0.rangeOfString("."+exitension) != nil}
    }
    static func deleteFile(name:String) -> Bool{
        do {
            try NSFileManager.defaultManager().removeItemAtPath(Storage.documentsDirectory + "/" + name)
            return true
        }catch let error as NSError {
            NSLog("Canot remonve file: \(name) with erroe \(error)")
            return false
        }
    }
}