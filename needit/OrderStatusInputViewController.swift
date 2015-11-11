//
//  OrderStatusInputViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class OrderStatusInputViewController: UIViewController, UITextViewDelegate {
    
    // UI Outlet
    
    @IBOutlet weak var orderIdTextView: UITextView!
    
    // UI Action
    
    
    @IBAction func closeButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func orderStatusButtonClicked() {
        
        print("DOIN IT")
        
        if let id = getOrderId() {
            
            FirebaseUtils.singleton.getOrderById(id, onComplete: { orderOptional in
                
                if let order = orderOptional {
                    let osvc = self.storyboard?.instantiateViewControllerWithIdentifier("OrderStatusViewController") as! OrderStatusViewController
                    
                    osvc.order = order
                    
                    self.presentViewController(osvc, animated: true, completion: nil)
                } else {
                    print ("not a valid order id")
                }
                
            })
        } else {
            print("not a valid order id")
        }

    }
    
    // Class
    
    let placeholder = "AAA-AAA"
    
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
                    orderIdTextView.text = placeholder
                    orderIdTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            }
            return false
            
        
        }
        
        let resultingText = textView.text + text
        
        if (resultingText.characters.count > textView.text.characters.count) {
            if (textView.text.characters.count == 3) {
                textView.text = textView.text.stringByAppendingString("-")
            }
        }
        
        return textView.text.characters.count + (text.characters.count - range.length) <= 7;
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == "") {
                orderIdTextView.text = placeholder
                orderIdTextView.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
        }
    }
    
    
    
    func normalizeTextColor(textColor: UIColor) -> UIColor {
        var newColor = UIColor()
        
        newColor = textColor.colorWithAlphaComponent(1.00)
        
        return newColor
    }
    
    func dismissKeyboard() {
        orderIdTextView.endEditing(true)
    }
    
    func getOrderId() -> String? {
        let inputId = orderIdTextView.text as NSString
        
        if inputId.length < 7 {
            return nil
        }
        
        let front = inputId.substringToIndex(3)
        let back = inputId.substringFromIndex(4)
        
        return front + back
    }
}

