//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page8ViewController: PageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja7-A"),
            UIImage(named: "ilustracja7-B"),
            UIImage(named: "ilustracja7-C"),
            UIImage(named: "ilustracja7-D")]
        self.animationImage.alpha = 0
        self.pageNumber = 8
        self.objectType = .SkyFlying
    }
}
