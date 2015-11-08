//
//  WorldEditor.swift
//  pantiptop
//
//  Created by Kamil Wasag on 10.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class WorldEditor: UIViewController , UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, CILBasicObjectDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var drawingCanvas: CILDravingPallete!
    @IBOutlet weak var elementsPallete: UITableView!
    //MARK: - popertis
    var fileName:String?
        
    private var newObject:CILBasicObject?
    private var newobjectStartingPOint:CGPoint?
    
    lazy var paleteObjects:Array<String> = Storage.filesForExtension(FilesAndStorage.drawnWordElementsExtension)
    
    //MARK: - IBActions
    
    @IBAction func decreaseAlphaAction(sender: UIButton) {
        if self.newObject!.alpha >= 0.1 {
            self.newObject!.alpha -= 0.1
        }
    }
    
    @IBAction func increaseAlphaAction(sender: AnyObject) {
        if self.newObject!.alpha <= 0.9 {
            self.newObject!.alpha += 0.1
        }
    }
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        var objects:Array<WorldObject> = Array<WorldObject>()
        if self.fileName == nil {
            self.fileName = NSUUID().UUIDString + ".\(FilesAndStorage.drownWordExtension)"
        }
        
        for  object in self.drawingCanvas.subviews {
            if let currentObject = object as? CILBasicObject{
                var angle:CGFloat = currentObject.rotationAngle
                currentObject.transform = CGAffineTransformIdentity
                var frame:CGRect = object.frame
                currentObject.transform = CGAffineTransformMakeRotation(angle)
                objects.append(WorldObject(fileName: self.paleteObjects[currentObject.tag], frame: frame, rotation: angle, alpha: currentObject.alpha))
            }
        }
        NSKeyedArchiver.archiveRootObject(objects, toFile: Storage.documentsDirectory + "/" + self.fileName!)
        
        
        func showSaveInfo (){
            PTTPopUpContainer.sharedContainer.insideView = {
                let label = PttLabel()
                label.fontSize = UIFont.systemFontSize()*2
                label.textColor = UIColor.whiteColor()
                label.text = "Świat został zapisany"
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
        self.dismissVCAction(self)
        
    }
    
    
    @IBAction func dismissVCAction(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementsPallete.separatorColor = UIColor(patternImage: UIImage(named: "palleteCellDivider")!)
    }
    
    //MARK: - UITableViewDataSource method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paleteObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier:String = "drawElement"
        let cell:PaleteCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PaleteCell
        
        cell.cellImage.image = UIImage(contentsOfFile: Storage.documentsDirectory + "/" + self.paleteObjects[indexPath.row])
        cell.backgroundColor = UIColor.clearColor()
        let tapGesture = UIPanGestureRecognizer(target: self, action: "panCell:")
        tapGesture.delegate = self
        cell.addGestureRecognizer(tapGesture)
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if ( Int(self.paleteObjects[indexPath.row].pathExtension) == nil){
            if editingStyle == UITableViewCellEditingStyle.Delete {
                
            }
        }
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if ( Int(self.paleteObjects[indexPath.row].pathExtension) != nil) {return false}
        return true
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if ((indexPath.row < self.paleteObjects.count) && (indexPath.row >= 0)){
            if ( Int(self.paleteObjects[indexPath.row].pathExtension) == nil){
                let action:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "     ") { (UITableViewRowAction, NSIndexPath) -> Void in
                    Storage.deleteFile(self.paleteObjects[indexPath.row])
                    self.paleteObjects.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
                action.backgroundColor = UIColor(patternImage: UIImage(named: "tableDel")!)
                
                return [action]
            }
        }
        return nil
    }
    
    //MARK: - gesture recoginzers selectors
    func panCell(panGesture:UIPanGestureRecognizer){
        
        if panGesture.state == UIGestureRecognizerState.Began {
            self.newObject = CILBasicObject(frame: CGRect(x: 0, y: 0, width: panGesture.view!.frame.width+10, height: panGesture.view!.frame.width+10), image: (panGesture.view as! PaleteCell).cellImage.image!)
            self.drawingCanvas.disableDrawingObjects()
            self.newObject?.imageMargin = 13
            self.newObject?.frame = self.newObject!.frame
            self.newObject?.blockRatio = true
            self.newObject?.delegate = self
            self.newObject?.borderColor = UIColor.whiteColor()
            self.newObject?.borderSize = 1
            self.newObject?.cornerCurveRadius = 13
            self.newObject?.borderdDuringEditing = true
            self.newObject?.tag = panGesture.view!.tag
            self.newObject?.backgroundColor = UIColor.clearColor()
            self.newObject!.center = self.view.convertPoint(panGesture.view!.center, fromView: self.elementsPallete)
            self.newobjectStartingPOint = self.newObject!.center
            self.view.addSubview(self.newObject!)
        }else if panGesture.state == UIGestureRecognizerState.Changed {
            let translation:CGPoint = panGesture.translationInView(self.view)
            self.newObject!.center = CGPoint(x: self.newObject!.center.x+translation.x, y: self.newObject!.center.y+translation.y)
        }else{
            if CGRectContainsPoint(self.drawingCanvas.frame, self.newObject!.center)
            {
                self.newObject!.removeFromSuperview()
                self.newObject!.center = self.drawingCanvas.convertPoint(self.newObject!.center, fromView: self.view)
                self.drawingCanvas.addSubview(self.newObject!)
                self.newObject!.enabled = true
            }else{
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.newObject!.center = self.newobjectStartingPOint!
                    }, completion: { (Bool) -> Void in
                        if (self.newObject != nil){
                            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                                self.newObject!.alpha = 0.0
                                }, completion: { (Bool) -> Void in
                                    self.newObject!.removeFromSuperview()
                                    self.newObject = nil
                                    self.newobjectStartingPOint = nil
                            })
                        }
                })
            }
        }
        panGesture.setTranslation(CGPointZero, inView: self.view)
    }
    
    //MARK: - UIGestureRecognizerDelagte methods
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let _ = gestureRecognizer.view! as? PaleteCell, let gesture =  gestureRecognizer as? UIPanGestureRecognizer{
            let transformation:CGPoint = gesture.translationInView(self.view)
            if transformation.x < 0  || abs(transformation.y) > abs(transformation.x){
                return false
            }
        }
        return true
    }
    
    //MARK: - CILBasicObjectDelegate
    
    func elementEnabled(element:CILBasicObject){
        self.newObject = element
    }
    
    @IBAction func unselectElements(sender: UITapGestureRecognizer) {
        self.drawingCanvas.disableDrawingObjects()
    }
}