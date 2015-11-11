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
    
    var name: String
    var quantity: Int
    var discount: Double!
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
    
}