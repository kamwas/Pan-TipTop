//
//  Page3ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page15ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja14-A"),UIImage(named: "ilustracja14-B"),UIImage(named: "ilustracja14-C")]
        self.animationImage.alpha = 0
        self.pageNumber = 15
        self.objectType = .WaterSwiming
    }
    
}
