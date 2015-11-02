//
//  Page2ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page11ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja10-A"),
            UIImage(named: "ilustracja10-B"),
            UIImage(named: "ilustracja10-C"),
            UIImage(named: "ilustracja10-D"),
            UIImage(named: "ilustracja10-E")]
        self.animationImage.alpha = 0
        self.pageNumber = 11
         self.objectType = .GroundMoving
    }
}
