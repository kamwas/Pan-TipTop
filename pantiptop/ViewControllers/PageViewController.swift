//
//  PageViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 19.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit
import AVFoundation

protocol PageViewControllerDelegate{
    func goToPreviousPageWithPageViewController(pageViewController: PageViewController)
    func goToNextPageWithPageViewController(pageViewController: PageViewController)
    func goToFirstPage()
}

class PageViewController: UIViewController {
//MARK: - Properies
    var objectType:DrawingType = .NotDefine
    @IBOutlet weak var playButton:UIButton!
    var pageNumber:NSInteger = 0
    var delegate : PageViewControllerDelegate?
    var lectorName:String {
        return String(self.pageNumber)+".mp3"
    }
    
    lazy var player:AVAudioPlayer? = {
        do {
            if let path = NSBundle.mainBundle().pathForResource(String(self.pageNumber), ofType: "mp3") {
                return try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path))
            } else {
                return try AVAudioPlayer(data: NSData(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(String(self.pageNumber), ofType: "m4a")!))!)
            }
        }catch{
            return nil
        }
    }()
//MARK: - IBOutlets
    @IBOutlet weak var animationImage: BlinkingImages!
//MARK: - IBActions
    @IBAction func playLectorActionButton () {
        if self.player != nil {
            if self.player!.playing {
                self.player!.pause()
                self.playButton.selected = false
            } else{
                self.player!.prepareToPlay()
                self.player!.play()
                self.playButton.selected = true
            }
        }
    }
    
    @IBAction func nextPage () {
        self.delegate?.goToNextPageWithPageViewController(self)
    }
    
    @IBAction func previosPage (){
        self.delegate?.goToPreviousPageWithPageViewController(self)
    }
    
    @IBAction func openGallery(sender:UIButton){
        if Storage.filesForExtension(FilesAndStorage.drownWordExtension).count > 0{
        self.pushVCWithIdentifier("browseWorlds")
        }else{
            self.showSaveInfo("Brak elementów do przegladania! Stwórz jakiś żeby wejść do galerii.")
            self.openWorldEditor(sender)
        }
    }
    
    @IBAction func openWorldEditor(sender:UIButton){
        if Storage.filesForExtension(FilesAndStorage.drawnWordElementsExtension).count > 0 {
           self.pushVCWithIdentifier("drawWorld")
        }else{
            self.showSaveInfo("Brak elemntów świata, narysuj jakiś żeby zacząć budowę")
        }
        
    }
    
    @IBAction func openDrawing(sender:UIButton){
        let vc:DrawingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("drawElement") as! DrawingViewController
        vc.pageNumber = self.pageNumber
        presentViewController(vc , animated: true, completion:nil)
    }


//MARK: - lifecycle functions
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (self.animationImage != nil){
            self.animationImage.alpha = 1
        }
    }
    

//MARK: - Seguey functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let currentSegue = segue.destinationViewController as? DrawingViewController{
            currentSegue.pageNumber = self.pageNumber
            currentSegue.objectType = self.objectType
        }
    }
    
//MARK: - Helpers    
    private func pushVCWithIdentifier(identifier:String) -> UIViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifier) 
        presentViewController(vc , animated: true, completion:nil)
        return vc
    }
    
    private func showSaveInfo (info:String){
        let block = {()->Void in
            PTTPopUpContainer.sharedContainer.insideView = {
                let label = PttLabel()
                label.fontSize = UIFont.systemFontSize()*2
                label.textColor = UIColor.whiteColor()
                label.text = info
                label.sizeToFit()
                return label
                }()
            PTTPopUpContainer.show(CGPoint(x:self.view.center.x, y:self.view.frame.height*0.75), delay: 5)
        }
        if PTTPopUpContainer.sharedContainer.isVisible {
            PTTPopUpContainer.dismiss(afterDelay: 3, completionBlock:block)
        }else{
            block()
        }
    }

}