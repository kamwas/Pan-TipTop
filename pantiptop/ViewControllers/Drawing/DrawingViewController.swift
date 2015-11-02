//
//  DrawingViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 03.06.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//MARK: - private properties
    private var imageNmame:String = NSUUID().UUIDString
    private let minimumBrushSize:CGFloat = 4
    private let maximumBrushSize:CGFloat = 20
    private let backgorundCellStringIdentifier:String = "BackgorundCellIdentifier"
    
    @IBOutlet weak var clearButton: PTTColorButton!
    
//MARK: - properties

    var pageNumber:Int = 0 {
        didSet{
            
        }
    }
    var objectType:DrawingType = .NotDefine
    lazy var backgroundGrid:UICollectionView = {
        var collection:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 300), collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: self.backgorundCellStringIdentifier)
        return collection
    }()
    
    lazy var backgrounds:Array<String> = {
        var images:Array<String> = Array<String>()
        var image:UIImage?
        var number:Int = 1
        for number ; UIImage(named: "pod-"+String(self.pageNumber)+"-"+String(number)) != nil ; number++ {
            images.append("pod-"+String(self.pageNumber)+"-"+String(number))
        }
        images.append("noBackground")
        return images
    }()
    
//MARK: - UICollection
    @IBOutlet weak var pointerLineWidth: UIImageView!
    @IBOutlet weak var pointerRightLineWidth: UIImageView!
    @IBOutlet weak var pointerLeftLineWidth: UIImageView!
    @IBOutlet weak var pointerScaleWidth: UIView!
    @IBOutlet weak var dravingCanvas: DrawingView!
//MARK: - UICollectionOutlets
    
    @IBOutlet var colorButtons: [PTTColorButton]!
    
//MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dravingCanvas.currentColor = colorButtons[0].pickColor
        colorButtons[0].selectButton()
        self.pointerLineWidth.userInteractionEnabled = true
        self.pointerLineWidth.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "panPointer:"))
        self.dravingCanvas.backgroundImage = UIImage(named:self.backgrounds[0])
    }
//MARK: - IBActions
    @IBAction func colorSelected(sender: PTTColorButton) {
        for button in colorButtons{
            if (button==sender){
                self.dravingCanvas.currentColor = button.pickColor
            }else{
                button.deselectButton()
            }
        }
    }
    
    @IBAction func dismissMe(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func resetButtonAction(sender: AnyObject) {
        self.dravingCanvas.reset()
    }
    
    @IBAction func showBackgorundAction(sender: UIButton) {        
        if PTTPopUpContainer.sharedContainer.isVisible {
            PTTPopUpContainer.dismiss()
        }else{
            PTTPopUpContainer.sharedContainer.insideView = self.backgroundGrid
            PTTPopUpContainer.showAtPoint(self.view.center)
        }
    }
    
    @IBAction func saveImage(sender: AnyObject) {
        var imagePath:String = Storage.documentsDirectory + "/" + String(self.objectType.rawValue) + "-" + self.imageNmame + "." + FilesAndStorage.drawnWordElementsExtension
        UIImagePNGRepresentation(self.dravingCanvas.getImage())!.writeToFile(imagePath, atomically: true)
        
        func showSaveInfo (){
            PTTPopUpContainer.sharedContainer.insideView = {
                let label = PttLabel()
                label.fontSize = UIFont.systemFontSize()*2
                label.textColor = UIColor.whiteColor()
                label.text = "Obrazek został zapisany"
                label.sizeToFit()
                return label
                }()
            PTTPopUpContainer.show(CGPoint(x:self.view.center.x, y:self.view.frame.height*0.75), delay: 5)
        }
        
        
        if PTTPopUpContainer.sharedContainer.isVisible {
            PTTPopUpContainer.dismiss(showSaveInfo())
        }else{
            showSaveInfo()
        }
        self.dismissMe(self)
    }
//MARK: - GestureRecognizer actions
    func panPointer(sender:UIPanGestureRecognizer){
        let newCenter:CGPoint = CGPointMake(self.pointerLineWidth.center.x + sender.translationInView(self.view).x, self.pointerLineWidth.center.y);
        if (newCenter.x - self.pointerLineWidth.frame.width/2+5 >= CGRectGetMaxX(self.pointerLeftLineWidth.frame) &&
            newCenter.x + self.pointerLineWidth.frame.width/2-5 <= CGRectGetMinX(self.pointerRightLineWidth.frame)){
            self.pointerLineWidth.center = newCenter
                
            self.dravingCanvas.lineWidth = (self.maximumBrushSize - self.minimumBrushSize) * (self.pointerLineWidth.center.x - CGRectGetMinX(self.pointerScaleWidth.frame))/self.pointerScaleWidth.frame.width + self.minimumBrushSize
        }
        sender.setTranslation(CGPointZero, inView: self.view)
    }
//MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.backgrounds.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.backgorundCellStringIdentifier, forIndexPath: indexPath) 
        
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 0.5
        
        let image:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        image.contentMode = .ScaleAspectFit
        image.image = UIImage(named:self.backgrounds[indexPath.row])
        cell.addSubview(image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(115, 115);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.backgrounds.count - 2 >= indexPath.row {
            self.dravingCanvas.backgroundImage = UIImage(named:self.backgrounds[indexPath.row])
        }else{
            self.dravingCanvas.backgroundImage = nil
        }
        PTTPopUpContainer.dismiss()
    }
}