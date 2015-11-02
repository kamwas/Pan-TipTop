//
//  PttLabel.swift
//  Pan Tip Top
//
//  Created by Kamil Wasag on 02.11.2015.
//  Copyright © 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class PttLabel : UILabel{
    
    override var font: UIFont! {
        didSet {
            super.font = UIFont(name: Fonts.defaultFontName, size: (self.font?.pointSize)!)
        }
    }
    
    var fontSize:CGFloat {
        get{
            return self.font.pointSize
        }
        
        set(newValue){
            font = UIFont(name: Fonts.defaultFontName, size: fontSize)
        }
    }
}
