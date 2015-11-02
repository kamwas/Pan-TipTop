//
//  Page3ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page14ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja13-A"),UIImage(named: "ilustracja13-B")]
        self.animationImage.alpha = 0
        self.pageNumber = 14
        self.objectType = .GroundMoving
    }
    
}
