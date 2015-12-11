//
//  FirebaseUtils.swift
//  needit
//
//  Created by Izaak Prats on 10/18/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import Firebase
import UIKit

private var sharedInstance = FirebaseUtils()

class FirebaseUtils {
    
    let firebaseRef: Firebase
    let orderRef: Firebase
    
    class var singleton: FirebaseUtils {
        return sharedInstance
    }
    
    init() {
        firebaseRef = Firebase(url: "https://blistering-heat-3884.firebaseio.com/")
        orderRef = Firebase(url: "https://blistering-heat-3884.firebaseio.com/orders")
    }
    
    func loginWithCrendetials(email: String, password: String, onComplete: (NSError?) ->()) {
        
    }
    
    func getValidOrderId(onComplete: (String) -> ()) {
        let possibleId = randomStringWithLength(6)
        
        print("newid")
        
        isUniqueId(possibleId) { success in
            if (success) {
                // Return the unique ID
                print("success")
                onComplete(possibleId)
            } else {
                print("fail")
                // Recursively call the function until there is a unique ID.
                self.getValidOrderId(onComplete)
            }
        }
        
        
    }
    
    func isUniqueId(id: String, completionHandler: (Bool) -> ()) {
        let newRef = orderRef.childByAppendingPath(id)
        
        newRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                if snapshot.value is NSNull {
                    // The id is unique
                    completionHandler(true)
                } else {
                    // The id is not unique
                    completionHandler(false)
                }
        })
    }
    
    func pushCurrentOrder(onComplete: (NSError?) -> ()) {
        let orderDictionary = dictionaryForOrder(Order.currentOrder)
        let orderPath = orderRef.childByAppendingPath(Order.currentOrder.id)
        
        orderPath.setValue(orderDictionary, withCompletionBlock: {
            (error:NSError?, ref:Firebase!) in
                if (error != nil) {
                    print("Firebase had an issue")
                    onComplete(error)
                } else {
                    onComplete(nil)
                }
        })
    }
    
    func getOrderById(id: String, onComplete: (Order?) -> ()) {
        let newRef = orderRef.childByAppendingPath(id)
        
        newRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                print("Order does not exist")
                onComplete(nil)
            } else {
                print("Order does exist")
                onComplete(orderFromSnapshot(snapshot.value as? NSDictionary))
            }
        })
    }
    
    func getUserById(id: String, onComplete: (User?) -> ()) {
        let newRef = firebaseRef.childByAppendingPath("users/\(id)")
        
        newRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                print("Order does not exist")
                onComplete(nil)
            } else {
                print("Order does exist")
                onComplete(userFromSnapshot(snapshot.value as? NSDictionary))
            }
        })
    }
}