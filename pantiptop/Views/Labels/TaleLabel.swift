//
//  TaleLabel.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit



class TaleLabel: PttLabel {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup ()
    {
        self.textColor = UIColor(red: 196.0/256.0, green: 186.0/256.0, blue: 141.0/256.0, alpha: 1.0)
    }

}
