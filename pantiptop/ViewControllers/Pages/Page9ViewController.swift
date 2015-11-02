//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page9ViewController: PageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja8-A"),
            UIImage(named: "ilustracja8-B"),
            UIImage(named: "ilustracja8-C"),
            UIImage(named: "ilustracja8-D")]
        self.animationImage.alpha = 0
        self.pageNumber = 9
        
        self.objectType = .GroundMoving
    }
}
