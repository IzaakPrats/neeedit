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
    }
}