//
//  Page2ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page13ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja12-A"),
            UIImage(named: "ilustracja12-C"),
            UIImage(named: "ilustracja12-B")]
        self.animationImage.alpha = 0
        self.pageNumber = 13
        
        self.objectType = .GroundMoving
    }
}
