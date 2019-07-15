//
//  ViewController.swift
//  PizzaApp
//
//  Created by mac on 7/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {
    
    @IBOutlet weak var pizzaTableView: UITableView!
    
    //DidSet and WillSet, are called property observers
    var pizzas = [Pizza]() {
        //called BEFORE the value is changed
        willSet {
            
        }
        //didSet is called AFTER the value is changed
        didSet {
            pizzaTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //closures almost always cause retain cycles - escaping closure having a seperate life span than the function it resides in
        PizzaManager.shared.getPizza { [unowned self] pizza in
            if let pies = pizza {
                self.pizzas = pies
                print("Pizza Count: \(self.pizzas.count)")
            }
        }
    }


}


//MARK: TableView

extension PizzaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PizzaTableCell.identifier, for: indexPath) as! PizzaTableCell
        
        let pizza = pizzas[indexPath.row]
        cell.configure(with: pizza)
        
        
        return cell
    }
    
}



extension PizzaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
