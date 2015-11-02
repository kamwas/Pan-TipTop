//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page6ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja5-A"),
            UIImage(named: "ilustracja5-B"),
            UIImage(named: "ilustracja5-C"),
        UIImage(named: "ilustracja5-D")]
        self.animationImage.alpha = 0
        self.pageNumber = 6
        
        self.objectType = .GroundFlying
        
    }
}
