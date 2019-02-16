//
//  ShippingTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/15/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class ShippingTableViewCell: UITableViewCell { //PB ep94 21mins
   
//MARK: IBOutlets
   
   @IBOutlet weak var customerNameLabel: UILabel! //PB ep95 2mins
   @IBOutlet weak var address1Label: UILabel! //PB ep95 2mins
   @IBOutlet weak var address2Label: UILabel! //PB ep95 2mins
   @IBOutlet weak var cityLabel: UILabel! //PB ep95 2mins
   @IBOutlet weak var stateLabel: UILabel! //PB ep95 2mins
   @IBOutlet weak var zipLabel: UILabel! //PB ep95 2mins
   @IBOutlet weak var phoneLabel: UILabel! //PB ep95 2mins
   
//MARK: Properties
   let shoppingCart = ShoppingCart.sharedInstance //PB ep95 3mins
   
   
   
   override func awakeFromNib() { //PB ep94 21mins
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(_ selected: Bool, animated: Bool) { //PB ep94 21mins
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
   
   internal func configureCell() { //PB ep95 2mins
      if let customer = shoppingCart.customer, let shippingAddress = shoppingCart.shippingAddress { //PB ep95 4mins unwrap customer and shippingAddress
         customerNameLabel.text = customer.name //PB ep95 4mins
         phoneLabel.text = customer.phone //PB ep95 4mins
         address1Label.text = shippingAddress.address1 //PB ep95 5mins
         
         if let address2 = shippingAddress.address2 {
            address2Label.text = address2 //PB ep95 5mins
         } else { address2Label.text = "" } //PB ep95 5mins
         cityLabel.text = "\(shippingAddress.city!)" //PB ep95 6mins
         stateLabel.text = shippingAddress.state! //PB ep95 6mins
         zipLabel.text = shippingAddress.zip! //PB ep95 7mins
      }
      
   }
   
}
