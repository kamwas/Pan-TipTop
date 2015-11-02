//
//  Page3ViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 21.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class Page16ViewController: PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationImage.images  = [UIImage(named: "ilustracja15-A"),
            UIImage(named: "ilustracja15-B"),
            UIImage(named: "ilustracja15-C"),
            UIImage(named: "ilustracja15-D"),
            UIImage(named: "ilustracja15-E")]
        self.animationImage.alpha = 0
        self.pageNumber = 16
    }
    
    @IBAction func goToFirstPage(){
        self.delegate?.goToFirstPage()
    }
}
