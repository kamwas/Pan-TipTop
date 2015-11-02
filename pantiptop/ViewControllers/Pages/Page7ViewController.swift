//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page7ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja6-A"),
            UIImage(named: "ilustracja6-B"),
            UIImage(named: "ilustracja6-C"),
            UIImage(named: "ilustracja6-D")]
        self.animationImage.alpha = 0
        self.pageNumber = 7
        
        self.objectType = .SkyFlying
    }
}
