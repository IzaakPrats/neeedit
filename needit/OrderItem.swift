//
//  OrderItem.swift
//  needit
//
//  Created by Izaak Prats on 10/17/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class OrderItem {
    
    var itemName: String
    var itemQuantity: NSInteger
    var itemDiscount: NSDecimal!
    
    init(itemName: String, itemQuantity: NSInteger) {
        self.itemName = itemName
        self.itemQuantity = itemQuantity
    }
    
}