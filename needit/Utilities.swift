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