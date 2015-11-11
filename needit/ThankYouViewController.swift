//
//  ThankYouViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/19/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class ThankYouViewController: UIViewController {
    
    // UI Outlets
    
    @IBOutlet weak var orderLabel: UILabel!
    
    @IBOutlet weak var sentYouLabel: UILabel!
    
    // UI Actions
    
    @IBAction func doneButtonClicked() {
        
        let mvc = self.storyboard?.instantiateInitialViewController()
        
        self.presentViewController(mvc!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currentOrder = Order.currentOrder
        
        let id = currentOrder.id as NSString
        let readableId = "\(id.substringToIndex(3))-\(id.substringFromIndex(3))"
        orderLabel.text = readableId
        
        var phone = false
        var email = false
        
        if let _ = currentOrder.phone {
            phone = true
        }
        
        if let _ = currentOrder.email {
            email = true
        }
        
        if (phone && email) {
            sentYouLabel.text = "We just sent you an email and text with more information."
        } else if (phone) {
            sentYouLabel.text = "We just sent you a text with more information."
        } else if (email) {
            sentYouLabel.text = "We just sent you an email with more information."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

