//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page5ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja4-A"),
                                       UIImage(named: "ilustracja4-B"),
                                       UIImage(named: "ilustracja4-C")]
        self.animationImage.alpha = 0
        self.pageNumber = 5
        self.objectType = .GroundNotMove
    }
}
