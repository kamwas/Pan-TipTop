//
//  PreviewWorlds.swift
//  pantiptop
//
//  Created by Kamil Wasag on 13.07.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class PreviewWorlds: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
//MARK: - IBOutlets
    @IBOutlet var collectionView:UICollectionView!
//MARK: - Properties
    
    lazy var worldsFiles:Array<String> = {
        return Storage.filesForExtension(FilesAndStorage.drownWordExtension)
    }()
    
    lazy var words:Array<Array<WorldObject>> = {
        var objects:Array<Array<WorldObject>> = Array<Array<WorldObject>>()
        for file in self.worldsFiles {
            objects.append(NSKeyedUnarchiver.unarchiveObjectWithFile(Storage.documentsDirectory + "/" + file) as! Array<WorldObject>)
        }
        return objects
        }()
    
    lazy var images:Dictionary<String,UIImage> = {
        var images:Dictionary<String,UIImage> = Dictionary<String,UIImage>()
        let imageFiles:Array<String> = Storage.filesForExtension(FilesAndStorage.drawnWordElementsExtension)
        for file in imageFiles{
            images[file] = UIImage(contentsOfFile: Storage.documentsDirectory + "/" + file)
        }
        
        return images
    }()
//MARK: - IBActions
    @IBAction func dismissVCAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func deleteElement(sender: AnyObject) {
        let indexPath:NSIndexPath = self.collectionView.indexPathForCell(self.getCurrentCell()!)!
        Storage.deleteFile(self.worldsFiles[indexPath.row])
        self.worldsFiles.removeAtIndex(indexPath.row)
        self.words.removeAtIndex(indexPath.row)
        self.collectionView.deleteItemsAtIndexPaths([indexPath])
        if self.words.count <= 0 {
            PTTPopUpContainer.sharedContainer.insideView = {
                let label = PttLabel()
                label.fontSize = UIFont.systemFontSize()*2
                label.textColor = UIColor.whiteColor()
                label.text = "Wszytkie światy usunięte, utwórz nowy"
                label.sizeToFit()
                return label
                }()
            PTTPopUpContainer.show(CGPoint(x:self.view.center.x, y:self.view.frame.height*0.75), delay: 5)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
//MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier:String = "worldPreview"
        let cell:WordPreviewCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WordPreviewCollectionCell
        cell.canAnimate = false
        cell.layer.removeAllAnimations()
        cell.canAnimate = true
        cell.images = self.images
        cell.objectToDisplay = self.words[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.words.count
    }
    //MARK: - UIScrollViewViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.collectionView.scrollToItemAtIndexPath(self.collectionView.indexPathForCell(self.getCurrentCell()!)!, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    //MARK: - Helpers    
    func getCurrentCell() -> UICollectionViewCell?{
        var rect:CGRect = self.view.frame
        rect.origin.x += self.collectionView.contentOffset.x
        for cell in self.collectionView.visibleCells() {
            if CGRectContainsPoint(rect, cell.center)
            {
                return cell
            }
        }
        return nil
    }
}
