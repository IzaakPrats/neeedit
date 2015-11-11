//
//  OrderStatusViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/21/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class OrderStatusViewController: UIViewController {
    
    // UI Outlets
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    @IBOutlet weak var thingNameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!    
    
    @IBAction func closeButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Class Vars
    
    var order: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUIFromOrder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUIFromOrder() {
        orderNumberLabel.text = "Order \(order.id)"
        thingNameLabel.text = (order.items[0] as! OrderItem).name
        fromLabel.text = order.fromAddress
        toLabel.text = order.toAddress
        nameLabel.text = order.name
        
        if let phoneNumber = order.phone {
            phoneNumberLabel.text = phoneNumber
        } else {
            phoneNumberLabel.hidden = true
        }
        
        if let emailString = order.email {
            emailLabel.text = emailString
        } else {
            emailLabel.hidden = true
        }
        
        if let status = order.status {
            if (status != "NOT_ACCEPTED") {
                
                /* Hide initial label
                Show label "They're going to \(from) now!"
                Display time accepted
                Display driver's information
                Name
                phone#
                currentLocation
                */
                
                if (status == "PURCHASED") {
                    /*
                        Hide label "They're going to \(from) now!
                        Show label "They're on their way to you."
                    
                        Display time purchased
                        Display additional confirmation that the order is on the way.
                    */
                }
                
                if (status == "DELIVERED") {
                    /*
                    Hide label "Tehy're on their way to you"
                    Show label "They're here."
                    
                    Show verification button.
                    
                    Display time delivered
                    Display additional confirmation that the order is on the way.
                    */
                }
                
                if (status == "VERIFIED") {
                    /* Hide label "They're here."
                        Show label "How was the service?"
                        
                        Hide everything but driver inforamtion
                        Show 5 star rating system.
                        Show additional notes.
                    */
                }
                
                if (status == "RATED") {
                    /* Hide everything
                        Show all times + driver profile.
                        display label "Thank you!"
                        display label "Share a photo with friends"
                    */
                }
            } else {
                /* Keep label
                   Display # of local drivers?
                */
            }
        }
    }
    
    
    
}

