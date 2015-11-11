//
//  Order.swift
//  needit
//
//  Created by Izaak Prats on 10/17/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

private var sharedOrder = Order()

class Order {
    var id: String!
    var name: String!
    var email: String!
    var phone: String!
    var fromAddress: String!
    var toAddress: String!
    var items: NSMutableArray
    var delivererId: String!
    var status: String!
    var timePosted: String!
    var timeAccepted: String!
    var timePurchased: String!
    var timeDelivered: String!
    var timeUserVerified: String!
    var timeDriverVerified: String!
    var timeVerified: String!
    var rating: Int!
    var additionalNotes: String!
    
    class var currentOrder: Order {
        return sharedOrder
    }
    
    func newOrder() {
        sharedOrder = Order()
    }
    
    init() {
        id = nil
        name = nil
        email = nil
        phone = nil
        fromAddress = nil
        toAddress = nil
        items = NSMutableArray()
        delivererId = nil
        status = nil
        timePosted = nil
        timeAccepted = nil
        timePurchased = nil
        timeDelivered = nil
        timeVerified = nil
        timeUserVerified = nil
        timeDriverVerified = nil
        rating = nil
        additionalNotes = nil
    }
}