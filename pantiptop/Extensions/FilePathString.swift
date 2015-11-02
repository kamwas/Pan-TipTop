//
//  FilePathString.swift
//  Pan Tip Top
//
//  Created by Kamil Wasag on 02.11.2015.
//  Copyright © 2015 Kamil Wasag. All rights reserved.
//

import Foundation

extension String {
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).stringByDeletingPathExtension
        }
    }
}
