//
//  PTTColorButton.swift
//  pantiptop
//
//  Created by Kamil Wasag on 07.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

@IBDesignable
class PTTColorButton: UIButton {
    
    @IBInspectable var pickColor:UIColor = UIColor.clearColor()
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
                layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            if self.selected{
                layer.borderWidth = borderWidth
            }
        }
    }
    
    @IBInspectable var cornerRaiusPercentage: CGFloat = 0 {
        didSet{
            if cornerRaiusPercentage>100 {cornerRaiusPercentage = 100}
            if cornerRaiusPercentage<0 {cornerRaiusPercentage = 0}
            self.layer.cornerRadius = cornerRaiusPercentage*0.005*min(self.frame.size.width, self.frame.size.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupInit()
    }
    
    private func setupInit(){
        self.addTarget(self, action: "buttonSelectedDeselect", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonSelectedDeselect(){
        if self.selected{
            self.deselectButton()
        }else{
            self.selectButton()
        }
    }
    
    func deselectButton () {
        self.selected = false
        self.layer.borderWidth = 0
    }
    
    func selectButton() {
        self.selected = true
        self.layer.borderWidth = self.borderWidth
    }
    
}
