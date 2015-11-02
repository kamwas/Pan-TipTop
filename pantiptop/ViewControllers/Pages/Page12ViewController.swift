//
//  Page2ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page12ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja11-B"),
                                       UIImage(named: "ilustracja11-A")]
        self.animationImage.alpha = 0
        self.pageNumber = 12
        
        self.objectType = .GroundMoving
    }
}
