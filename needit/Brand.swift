//
//  File.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import UIKit

class Brand {
    
    let name: String
    let thing: String
    let primaryColor: UIColor
    let secondaryColor: UIColor?
    let image: UIImage
    
    init(name: String, thing: String, primaryColor: UIColor?, secondaryColor: UIColor?, image: UIImage?) {
        self.name = name
        self.thing = thing
        self.primaryColor = primaryColor!
        self.secondaryColor = secondaryColor
        self.image = image!
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getThing() -> String {
        return self.thing
    }
    
    func getPrimaryColor() -> UIColor {
        return self.primaryColor
    }
    
    func getSecondaryColor() -> UIColor? {
        return self.secondaryColor
    }
    
    func getImage() -> UIImage {
        return self.image
    }
    
}