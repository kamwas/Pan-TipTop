//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page10ViewController: PageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja9-A"),
            UIImage(named: "ilustracja9-B"),
            UIImage(named: "ilustracja9-C")]
        self.animationImage.alpha = 0
        self.pageNumber = 10
        
        self.objectType = .WaterNotMovingBlinking
       
    }
}
