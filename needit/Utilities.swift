//
//  Utilities.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

func createTestItems() -> [BrandItem] {
    
    
    // COFFEE
    
    let starbucks = Brand(name: "Starbucks", thing: "Pumpkin Spice Latte + Banana Nut Bread", primaryColor: UIColor(hexString: "00592D"), secondaryColor: nil, image: UIImage(named: "Starbucks.jpg"))
    
    let coffee = BrandItem(name: "coffee", brand: starbucks)
    
    // BEER
    
    let fallscity = Brand(name: "Falls City Beer", thing: "Six Pack", primaryColor: UIColor(hexString: "c51230"), secondaryColor: nil, image: UIImage(named: "FallsCity.png"))
    
    let beer = BrandItem(name: "beer", brand: fallscity)
    
    // ICE CREAM
    
    let comfycow = Brand(name: "Comfy Cow", thing: "A double scoop of Police Man's Special", primaryColor: UIColor(hexString: "f5a3a9"), secondaryColor: nil, image: UIImage(named: "ComfyCow.jpg"))
    
    let icecream = BrandItem(name: "ice cream", brand: comfycow)
    
    let items = NSMutableArray()
    
    items.addObject(coffee)
    items.addObject(beer)
    items.addObject(icecream)
    items.addObject(BrandItem(name: "Something", brand: nil))
 
    return items.copy() as! [BrandItem]
}

func randomStringWithLength (len : Int) -> String {
    
    let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i++){
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString as String
}

func dictionaryForOrder(order: Order) -> NSDictionary {
    
    let orderDic = NSMutableDictionary()

    orderDic.setObject(order.id, forKey: "id")
    orderDic.setObject(order.name, forKey: "name")
    
    if let orderEmail = order.email {
        orderDic.setObject(orderEmail, forKey: "email")
    }
    
    if let orderNumber = order.phone {
        orderDic.setObject(orderNumber, forKey: "phone")
    }
    
    orderDic.setObject(order.fromAddress, forKey: "fromAddress")
    orderDic.setObject(order.toAddress, forKey: "toAddress")
    
    let itemArray = NSMutableArray()
    
    for orderItem in order.items {
        itemArray.addObject(dictionaryForItem(orderItem as! OrderItem))
    }
    
    orderDic.setValue(itemArray, forKey: "items")
    
    return orderDic
}

func dictionaryForItem(item: OrderItem) -> NSDictionary {
    
    let itemDic = NSMutableDictionary()
    
    itemDic.setObject(item.name, forKey: "name")
    itemDic.setObject(item.quantity, forKey: "quantity")
    itemDic.setObject(0, forKey: "discount")
    
    return itemDic
}

func orderFromSnapshot(snapshot: NSDictionary?) -> Order? {
    
    var order: Order!
    
    /*
    var id: String!
    var name: String!
    var email: String!
    var phone: String!
    var fromAddress: String!
    var toAddress: String!
    var items: NSMutableArray
    var deliverer: String!
    var status: Int!
    var delivererLocation: String!
    */

    if let value = snapshot {
        order = Order()
        
        order.id = value.objectForKey("id") as! NSString as String
        
        order.name = value.objectForKey("name") as! NSString as String
        
        if let email = value.objectForKey("email") as? NSString as? String {
            order.email = email
        }
        
        if let number = value.objectForKey("phoneNumber") as? NSString as? String {
            order.phone = number
        }
        
        order.fromAddress = value.objectForKey("fromAddress") as! NSString as String
        order.toAddress = value.objectForKey("toAddress") as! NSString as String
        
        let items = value.objectForKey("items") as! NSMutableArray
        
        for item in items {
            order.items.addObject(itemFromSnapshot(item))
        }
        
        if let status = value.objectForKey("status") as? NSString as? String {
            // SET STATUS HERE
            
            order.status = status
            
            // IF STATUS != NOT_ACCEPTED
            
            if (status != "NOT_ACCEPTED") {
                order.delivererId = value.objectForKey("driver") as! NSString as String
                order.timeAccepted = value.objectForKey("timeAccepted") as! NSString as String
                
                if (status == "PURCHASED") {
                    order.timePurchased = value.objectForKey("timePurchased") as! NSString as String
                }
                
                if (status == "DELIVERED") {
                    order.timeDelivered = value.objectForKey("timeDelivered") as! NSString as String
                    
                    if let userTime = value.objectForKey("timeUserVerified") as? NSString as? String {
                        order.timeUserVerified = userTime
                    }
                    
                    if let driverTime = value.objectForKey("timeDriverVerified") as? NSString as? String {
                        order.timeDriverVerified = driverTime
                    }
                }
                
                if (status == "VERIFIED") {
                    order.timeUserVerified = value.objectForKey("timeUserVerified") as! NSString as String
                    order.timeDriverVerified = value.objectForKey("timeDriverVerified") as! NSString as String
                    order.timeVerified = value.objectForKey("timeVerified") as! NSString as String
                }
                
                if (status == "RATED") {
                    order.rating = value.objectForKey("rating") as! NSNumber as Int
                    
                    if let notes = value.objectForKey("additionalNotes") as? NSString as? String {
                        order.additionalNotes = notes
                    }
                }
            }
        }
    }
    
    return order
}

func userFromSnapshot(snapshot: NSDictionary?) -> User? {
    
    var user: User!
    
    if let value = snapshot {
    let id = value.valueForKey("id") as! NSString as String
    let firstName = value.valueForKey("firstName") as! NSString as String
    let lastName = value.valueForKey("lastName") as! NSString as String
    let email = value.valueForKey("email") as! NSString as String
    let phoneNumber = value.valueForKey("phoneNumber") as! NSString as String
    let profilePictureURL = value.valueForKey("profilePictureURL") as! NSString as String
    var address = value.valueForKey("address") as? NSString as? String
    var orders = value.valueForKey("orders") as? NSMutableArray
    let typeInt = value.valueForKey("type") as! NSInteger
    var type = Type.User
        
    if (address == nil) {
        address = ""
    }

    if (orders == nil) {
        orders = NSMutableArray()
    }

    if (typeInt == 1) {
        type = Type.Deliverer
    }
        
    user = User(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, profilePictureURL: profilePictureURL, address: address!, orders: orders!, type: type)
    }
    
    return user
}

func driverFromDictionary(driverDic: NSDictionary) -> Deliverer? {
    
     /**** TODO ****/
    
    return nil
}

func itemFromSnapshot(itemSnapshot: AnyObject?) -> OrderItem {
    
    let itemDic = itemSnapshot as! NSDictionary
    
    let name = itemDic.objectForKey("name") as! NSString as String
    
    var discount = 0.0
    
    if let orderDiscount = itemDic.objectForKey("discount") as? NSNumber {
        discount = orderDiscount.doubleValue
    }
    
    let item = OrderItem(name: name, quantity: 1)
    item.discount = discount
    
    return item
}
