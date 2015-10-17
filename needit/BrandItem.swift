//
//  Item.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class BrandItem {
    
    let name: String
    let brand: Brand?
    
    init(name: String, brand: Brand?) {
        self.name = name
        self.brand = brand
    }
    
}