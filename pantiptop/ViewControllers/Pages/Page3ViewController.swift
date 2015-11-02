//
//  Page2ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page3ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja2-A"),
                                       UIImage(named: "ilustracja2-B")]
        self.animationImage.alpha = 0
        self.pageNumber = 3
        self.objectType = .SkyNotMoveBlinking
        
    }
}
