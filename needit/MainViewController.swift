//
//  MainViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/10/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    // UI Outlets
    
    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var needTextView: UITextView!
    
    // UI Actions
    
    @IBAction func loginButtonClicked() {
        
    }
    
    // Class Vars
    
    let things = ["coffee", "lawn mowed", "dry cleaning", "lunch", "ice cream", "beer", "wine"]
    var thingsIndex = 0
    
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "changeText", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeText() {
        thingsIndex++
        
        if(thingsIndex > (things.count - 1)) {
            thingsIndex = 0;
        }
        
        needLabel.text = "Need " + things[thingsIndex] + "?"
    }
    
}
