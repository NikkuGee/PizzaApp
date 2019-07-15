//
//  PizzaManager.swift
//  PizzaApp
//
//  Created by mac on 7/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias PizzaHandler = ([Pizza]?) -> Void

//Singleton - Is a single instance of an object in the applications life.

//1. does not allow inheritance
final class PizzaManager {
    
    
    //2. we need a shared instance - for access
    //static variables are global variables (can be used throughout application) and do not need a instance to access them
    static let shared = PizzaManager()
    
    //3. a private initialize - so no one else can create an instance outside of the declaration
    private init() {}
    
    
    //closures - are nameless blocks of functionality, that can be used to capture values asynchronously
    //escaping closure - closure has a seperate life span than the function that it resides in, allows for asynchronous call backs
    
    func getPizza(completion: @escaping PizzaHandler) {
        
        //GCD - Grand Central Dispatch - Native API used for basic multithreading
        //QOS - quality of service - priority of the queue -
        //1. userinitiated, 2. userinteractive, 3. default, 4. utility, 5. background
        
        DispatchQueue.global(qos: .utility).async {
            
            guard let path = Bundle.main.path(forResource: "pizzas", ofType: "json") else {
                completion(nil)
                return
            }
            
            let pizzaURL = URL(fileURLWithPath: path)
            
            var pizzas = [Pizza]()
            
            do {
                let data = try Data(contentsOf: pizzaURL)
                
                if let pizzaJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                    
                    for dict in pizzaJson {
                        let pizza = Pizza(json: dict)
                        pizzas.append(pizza)
                    }
                    
                    //go back to main thread for completion
                    DispatchQueue.main.async {
                        completion(pizzas)
                    }
                }
                
            } catch {
                
                print("Couldn't make pizzas: \(error.localizedDescription)")
                
            }
            
        }
    } //end func
    
    
    
    
    
    
}//end class
