//
//  ReviewOrderViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/17/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class ReviewOrderViewController: UIViewController {
    
    // UI Outlets
    
    @IBOutlet weak var orderTextView: UITextView!
    
    // I need ___ from ____ delivered to ___.
    
    
    // UI Actions
    
    @IBAction func placeOrderButtonClicked() {
        
        // DO STUFF
        
    }
    
    @IBAction func backButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let thing = (Order.currentOrder.items[0] as! OrderItem).itemName
        let from = Order.currentOrder.fromAddress
        
        let to = Order.currentOrder.toAddress
        
        let complete =  "I need \(thing) from \(from) delivered to \(to)."
        
        orderTextView.text = complete
        orderTextView.selectable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSentence() -> String {
        
        let thing = (Order.currentOrder.items[0] as! OrderItem).itemName
        
        let from = Order.currentOrder.fromAddress
        
        let to = Order.currentOrder.toAddress
        
        return "I need \(thing) from \(from) delivered to \(to)."
        
    }
    
    
}


