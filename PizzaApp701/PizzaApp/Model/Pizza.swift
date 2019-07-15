//
//  Pizza.swift
//  PizzaApp
//
//  Created by mac on 7/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class Pizza {
    
    let toppings: [String]
    let price: Int?
    
    
    init(json: [String:Any]) {
        
        self.toppings = json["toppings"] as! [String]
        self.price = json["price"] as? Int ?? 10 //nil coalescing, give's default value to an optional
        
    }
    
    init(toppings: [String], price: Int?) {
        self.toppings = toppings
        self.price = price
    }
    
}
