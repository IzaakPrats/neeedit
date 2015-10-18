//
//  WhereViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class WhereViewController: UIViewController, UITextViewDelegate {
    
    // UI Outlets
    
    @IBOutlet weak var whereFromTextView: UITextView!
    
    @IBOutlet weak var whereToTextView: UITextView!
    
    // UI Actions
    
    @IBAction func backButtonClicked() {
        
        // This works for now?
        // Why won't the navigation controller work?
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func nextButtonClicked() {
        
        
        
    }
    
    // Class Vars
    
    let fromPlaceholder = "Where should we get that from?"
    let toPlaceholder = "Where are we bringing it?"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let fromText = whereFromTextView.text {
            Order.currentOrder.fromAddress = fromText }
        
        if let whereText = whereToTextView.text {
            Order.currentOrder.toAddress = whereText
        }
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textView.text = ""
        
        var textColor = textView.textColor
        textColor = normalizeTextColor(textColor!)
        
        textView.textColor = textColor
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            
            if(textView.text == "") {
                if (textView == whereFromTextView) {
                    whereFromTextView.text = fromPlaceholder
                    whereFromTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
                } else {
                    whereToTextView.text = toPlaceholder
                    whereToTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
                }
            }
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == "") {
            if (textView == whereFromTextView) {
                whereFromTextView.text = fromPlaceholder
                whereFromTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            } else {
                whereToTextView.text = toPlaceholder
                whereToTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            }
        }

        // beginBrandLoop()
    }
    
    func normalizeTextColor(textColor: UIColor) -> UIColor {
        var newColor = UIColor()
        
        newColor = textColor.colorWithAlphaComponent(1.00)
        
        return newColor
    }

    func dismissKeyboard() {
        whereFromTextView.endEditing(true)
        whereToTextView.endEditing(true)
    }
}

