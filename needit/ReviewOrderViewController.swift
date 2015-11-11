//
//  ReviewOrderViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/17/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ReviewOrderViewController: UIViewController {
    
    // UI Outlets
    
    @IBOutlet weak var orderTextView: UITextView!
    
    // I need ___ from ____ delivered to ___.
    
    
    // UI Actions
    
    @IBAction func placeOrderButtonClicked() {
        
        // DO STUFF
        
        
        
        FirebaseUtils.singleton.getValidOrderId() { orderId in
            
            Order.currentOrder.id = orderId
            
            FirebaseUtils.singleton.pushCurrentOrder() { error in
             
                if error != nil {
                    // THERE WAS AN ISSUE
                } else {
                    // THERE IS NO ISSUE, CARRY ON
                    // GO TO THANKYOU SCREEN
                    
                   self.goToThankYou()
                }
                
            }
        }
        
    }
    
    @IBAction func backButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let thing = (Order.currentOrder.items[0] as! OrderItem).name
        let from = Order.currentOrder.fromAddress
        
        let to = Order.currentOrder.toAddress
        
        let complete =  "I need \(thing) from \(from) delivered to \(to) "
        
        orderTextView.text = complete
        orderTextView.selectable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSentence() -> String {
        
        let thing = (Order.currentOrder.items[0] as! OrderItem).name
        
        let from = Order.currentOrder.fromAddress
        
        let to = Order.currentOrder.toAddress
        
        return "I need \(thing) from \(from) delivered to \(to)."
        
    }
    
    func goToThankYou() {
        let thankYouViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ThankYouViewController") as! ThankYouViewController
        
        self.presentViewController(thankYouViewController, animated: true, completion: nil)
    }
    
    
}


