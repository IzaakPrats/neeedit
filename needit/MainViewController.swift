//
//  MainViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/10/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITextViewDelegate {
    
    // UI Outlets
    
    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var needTextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // UI Actions
    
    @IBAction func loginButtonClicked() {
        
    }
    
    @IBOutlet weak var orderStatusClicked: UIButton!
    
    
    // Class Vars
    
    let items = createTestItems();
    var itemsIndex = 0
    
    var timer = NSTimer()
    
    var placeholder = "Input your need here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        delay(2.0) {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "cycleOptions", userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cycleOptions() {
        if(itemsIndex > (items.count - 1)) {
            itemsIndex = 0;
        }
        
        let item = items[itemsIndex]
        
        // Change Title
        needLabel.text = "Need " + item.name + "?"
        
        if let brand = item.brand {
            
            // Change Title color
            
            needLabel.textColor = brand.getPrimaryColor()
            
            // Change placeholder text
            
            if (needTextView.text == placeholder) {
                needTextView.text = brand.getThing()
            }
            
            placeholder = brand.getThing()
            
            // Change text color
            
            if let secondaryColor = brand.getSecondaryColor() {
                
                needTextView.textColor = secondaryColor
                
            }
            
            // Change logo
            
            logoImageView.image = brand.getImage()
            
        } else {
            
            needLabel.textColor = UIColor.blackColor()
            
            if (needTextView.text == placeholder) {
                needTextView.text = "Input your need here..."
                needTextView.textColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
            }
            
            placeholder = "Input your need here..."
            
            logoImageView.image = nil
            
        }

        itemsIndex++
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textView.text = ""
        
        var textColor = textView.textColor
        textColor = normalizeTextColor(textColor!)
        
        textView.textColor = textColor
        
        timer.invalidate()
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            if(textView.text == "") {
                textView.resignFirstResponder()
                
                needTextView.text = placeholder
                needTextView.textColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
            } else {
                
                let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WhereViewController") as! WhereViewController
                self.navigationController?.presentViewController(nextViewController, animated: true, completion: nil)
                
            }
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        delay(2.0) {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "cycleOptions", userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        }
    }
    
    func normalizeTextColor(textColor: UIColor) -> UIColor {
        var newColor = UIColor()
        
        newColor = textColor.colorWithAlphaComponent(1.00)
        
        return newColor
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}
