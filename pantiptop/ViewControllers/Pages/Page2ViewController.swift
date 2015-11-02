//
//  Page1ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page2ViewController: PageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageNumber = 2
        self.animationImage.images  = [UIImage(named: "ilustracja1-A"),
                                       UIImage(named: "ilustracja1-B")]
        self.animationImage.alpha = 0
        
    }
}
