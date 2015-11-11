//
//  Deliverer.swift
//  needit
//
//  Created by Izaak Prats on 10/22/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class Deliverer: User {
    let currentLat: Double
    let currentLong: Double
    let activeOrders: NSMutableArray
    let completedOrders: NSMutableArray
    let avgRating: Int
    let ratings: NSMutableArray
    
    init(currentLat: Double, currentLong: Double, activeOrders: NSMutableArray, completedOrders: NSMutableArray, avgRating: Int, ratings: NSMutableArray, id: String, firstName: String, lastName: String, address: String, email: String, phoneNumber: String, profilePictureURL: String, orders: NSMutableArray) {
        
        self.ratings = ratings
        self.avgRating = avgRating
        self.currentLat = currentLat
        self.currentLong = currentLong
        self.activeOrders = activeOrders
        self.completedOrders = completedOrders
        
        super.init(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, profilePictureURL: profilePictureURL, address: address, orders: orders, type: .Deliverer)
    }
    
}