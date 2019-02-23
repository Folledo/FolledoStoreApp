//
//  OrderConfirmationViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/23/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController { //PB ep96 5mins
	
//MARK: IBOutlets
	@IBOutlet weak var orderConfirmationLabel: UILabel! //PB ep96 8mins
	
	
//MARK: Properties
	var shoppingCart = ShoppingCart.sharedInstance //PB ep96 9mins
	
	
    override func viewDidLoad() { //PB ep96 5mins
        super.viewDidLoad()
		
		let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil) //PB ep96 9mins to not allow users to go back once they go to this controller
		navigationItem.leftBarButtonItem = backButton //PB ep96 10mins assign it to our nav controller
		
		orderConfirmationLabel.text = UUID().uuidString //PB ep96 10mins get random String
    }
    
	
//MARK:IBAtions
	@IBAction func continueShoppingButtonTapped(_ sender: MyButton) { //PB ep96 8mins go back to home and reset the shopping Cart which we will create in the ShoppingCart
		dismiss(animated: true, completion: nil) //PB ep96 12mins
		shoppingCart.reset() //PB ep96 13mins
	}
	
	
	
}
