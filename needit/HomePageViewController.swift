//
//  HomePageViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/24/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class HomePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var viewController: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return viewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return viewController
    }
    
    
    
    
}