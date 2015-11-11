//
//  User.swift
//  needit
//
//  Created by Izaak Prats on 10/23/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum Type {
    case User
    case Deliverer
}

private var sharedUser: User!

class User {
    let id: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let email: String
    let profilePictureURL: String
    let address: String?
    let orders: NSMutableArray
    var type: Type
    
    class var currentUser: User {
        return sharedUser
    }
    
    func setCurrentUser(user: User) {
        sharedUser = user
    }
    
    init(id: String, firstName: String, lastName: String, phoneNumber: String, email: String, profilePictureURL: String, address: String, orders: NSMutableArray, type: Type) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.profilePictureURL = profilePictureURL
        self.address = address
        self.orders = orders
        self.type = type
    }
}