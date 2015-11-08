//
//  MainPageViewController.swift
//  pantiptop
//
//  Created by Kamil Wasag on 23.05.2015.
//  Copyright (c) 2015 Kamil Wasag. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, PageViewControllerDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    var pageIsAnimating:Bool = false
    var currentPage:Int = 0
    
    var allPages:Int {
        return 16
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.dataSource = self
        self.delegate = self
        if (NSUserDefaults.standardUserDefaults().integerForKey(UserDefaultsKeys.lastPageViewed) <= 1)
        {
            self.goToFirstPage()
        }else{
            self.goToPage(NSUserDefaults.standardUserDefaults().integerForKey(UserDefaultsKeys.lastPageViewed), animated: false)
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        self.pageIsAnimating = true
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        if (self.pageIsAnimating||(viewController as! PageViewController).pageNumber>=self.allPages){
            return nil;
        }
        return self.getViewControllerForNumber((viewController as! PageViewController).pageNumber+1,isCurrentPage: true)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        if (self.pageIsAnimating||(viewController as! PageViewController).pageNumber<2){
            return nil;
        }
        return self.getViewControllerForNumber((viewController as! PageViewController).pageNumber-1,isCurrentPage: true);
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed || finished){
            self.pageIsAnimating = false
        }
    }
    
    func goToFirstPage() {
        self.goToPage(1, animated: false)
    }
    
    func goToPage (page :Int, animated: Bool){
        self.currentPage = page
        self.setViewControllers([self.getViewControllerForNumber(self.currentPage,isCurrentPage: true)!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    private func getViewControllerForNumber(viewcontrollerNumber: NSInteger, isCurrentPage:Bool) -> PageViewController?{
        let patern = "Page"
        let vcName = patern+String(viewcontrollerNumber)
        let vc:PageViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(vcName) as? PageViewController
        if vc != nil {
            vc!.delegate = self
            vc!.pageNumber = viewcontrollerNumber
            if isCurrentPage {
                self.currentPage = viewcontrollerNumber
            }
        }
        return vc
    }
    
    func goToNextPageWithPageViewController(pageViewController :PageViewController)
    {
        if let nextViewController = self.getViewControllerForNumber(pageViewController.pageNumber+1, isCurrentPage: true) {
            self.setViewControllers([nextViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
    
    func goToPreviousPageWithPageViewController(pageViewController: PageViewController) {
        if let previousViewController = self.getViewControllerForNumber(pageViewController.pageNumber-1, isCurrentPage: true) {
            self.setViewControllers([previousViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        
    }
}