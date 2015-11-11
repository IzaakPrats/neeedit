//
//  CustomerInformationViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class CustomerInformationViewController: UIViewController, UITextViewDelegate {
    
    // UI Outlets
    
    @IBOutlet weak var nameTextView: UITextView!
    
    @IBOutlet weak var numberTextView: UITextView!
    
    @IBOutlet weak var emailTextView: UITextView!
    
    // UI Actions
    
    @IBAction func rightButtonClicked() {
        
        
        
    }
    
    @IBAction func backButtonClicked() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func showDeliveryFeeInfo() {
        
    }
    
    
    
    // Class Vars
    
    let namePlaceholder = "First and last."
    let numberPlaceholder = "So we can send you updates on your order."
    let emailPlaceholder = "So you can get your receipt!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if (nameTextView.text == namePlaceholder) {
            return false
        }
        
        if (emailTextView.text == "" && numberTextView.text == numberPlaceholder) {
            return false
        }
        
        if (numberTextView.text == "" && emailTextView.text == emailPlaceholder) {
            return false
        }
        
        if (numberTextView.text == numberPlaceholder && emailTextView.text == emailPlaceholder) {
            return false
        }
        
        if (numberTextView.text == "" && emailTextView.text == "") {
            return false
        }
        
        if let nameText = nameTextView.text {
            if (nameText == namePlaceholder) {
                return false
            } else {
                Order.currentOrder.name = nameText
            }
        } else {
            return false
        }
        
        if let numberText = numberTextView.text {
            if (numberText == numberPlaceholder || numberText == "") {
                Order.currentOrder.phone = nil
            } else {
                Order.currentOrder.phone = numberText
            }
        } else {
            return false
        }
        
        if let emailText = emailTextView.text {
            if (emailText == emailPlaceholder || emailText == "") {
                Order.currentOrder.email = nil
            } else {
                Order.currentOrder.email = emailText
            }
        } else {
            return false
        }
        
        return true
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
                if (textView == nameTextView) {
                    nameTextView.text = namePlaceholder
                    nameTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
                } else if (textView == numberTextView){
                    numberTextView.text = numberPlaceholder
                    numberTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
                } else if (textView == emailTextView) {
                    emailTextView.text = emailPlaceholder
                    emailTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
                }
            }
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        // beginBrandLoop()
        if(textView.text == "") {
            if (textView == nameTextView) {
                nameTextView.text = namePlaceholder
                nameTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            } else if (textView == numberTextView){
                numberTextView.text = numberPlaceholder
                numberTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            } else if (textView == emailTextView) {
                emailTextView.text = emailPlaceholder
                emailTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            }
        }

    }
    
    func normalizeTextColor(textColor: UIColor) -> UIColor {
        var newColor = UIColor()
        
        newColor = textColor.colorWithAlphaComponent(1.00)
        
        return newColor
    }
    
    func dismissKeyboard() {
        nameTextView.endEditing(true)
        numberTextView.endEditing(true)
        emailTextView.endEditing(true)
    }
    
}

