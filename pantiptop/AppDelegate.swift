//
//  AppDelegate.swift
//  pantiptop
//
//  Created by Kamil Wasag on 26.04.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let mainViewController:MainPageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainPageViewController
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if !NSUserDefaults.standardUserDefaults().boolForKey(UserDefaultsKeys.firstLaunching)
        {
            let coloredBackgorundFolderPath = "\(NSBundle.mainBundle().bundlePath)/\(FilesAndStorage.folderNameWithPredefinedElements)/"
            do{
                let coloredBackgroundFolderContent:Array<String> = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(coloredBackgorundFolderPath)
                for fileName in coloredBackgroundFolderContent {
                    do {
                        let srcFilePath = coloredBackgorundFolderPath+"/"+fileName
                        let dscFilePath = "\(Storage.documentsDirectory)/\(fileName.stringByDeletingPathExtension).\(FilesAndStorage.drawnWordElementsExtension)"
                        try NSFileManager.defaultManager().copyItemAtPath(srcFilePath, toPath: dscFilePath)
                    }catch let error as NSError{
                        NSLog("Copying error: \(error)")
                    }
                }
            }catch let error as NSError{
                NSLog("Getting backgrounds directory content: \(error)")
            }
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }catch let error as NSError{
            NSLog("Cant set audio category with error: \(error)")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            NSLog("Canot activate audio session \(error)")
        }
        
        window?.rootViewController = AppDelegate.mainViewController;
        
        PTTPopUpContainer.sharedContainer.borderColor = UIColor.whiteColor()
        PTTPopUpContainer.sharedContainer.borderSize = 1
        PTTPopUpContainer.sharedContainer.cornerCurveRadius = 13
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setInteger(AppDelegate.mainViewController.currentPage, forKey: AppDelegate.lastViewdPageKey)
        defaults.synchronize()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

