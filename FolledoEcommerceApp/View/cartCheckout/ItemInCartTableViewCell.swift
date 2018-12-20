//
//  ItemInCartTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 12/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ItemInCartTableViewCell: UITableViewCell { //PB ep79 1mins also created a xib file for it
   
//MARK: IBOutlets
   
   @IBOutlet weak var productImageView: UIImageView! //PB ep78 10mins
   @IBOutlet weak var productNameLabel: UILabel! //PB ep78 10mins
   @IBOutlet weak var qtyTextField: UITextField! //PB ep78 10mins
   @IBOutlet weak var priceLabel: UILabel! //PB ep78 10mins
   
   
//MARK: Properties
   var shoppingCart = ShoppingCart.sharedInstance //PB ep78 12mins
   var item: (product: Product, quantity: Int)? { //PB ep78 12mins item that we will show in the cell. This will be passed and set by the cart TVC
      didSet { //PB ep78 12mins once this item is being set by the CartTVC we're going to refresh the cell to show the latest item being passed in
         if let currentItem = item { //PB ep78 13mins
            refreshCell(currentItem: currentItem) //PB ep78 16mins
         }
         
      }
   }
   var itemIndexPath: IndexPath? //PB ep78 25mins will be used for TVC's cellForItemAt
   
   weak var delegate: ShoppingCartDelegate? //PB ep81 3mins there are 2 actions where we want to use this delegate
   
   
   
   override func awakeFromNib() { //PB ep78 1mins
      super.awakeFromNib()
        // Initialization code
      qtyTextField.delegate = self //PB ep78 16mins whenever cell is initiated, set our delegate to self, now we need to implement the TF delegate in our TableViewCell, through extension
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) { //PB ep78 1mins
      super.setSelected(selected, animated: animated)

      
   }
   
   
   
   
//MARK: Private functions
   private func refreshCell(currentItem: (product: Product, quantity: Int)) { //PB ep78 14mins once we get the currentItem, we can immediately update our views
      productImageView.image = Utility.image(withName: currentItem.product.mainImage, andType: "png") //PB ep78 14mins
      productNameLabel.text = currentItem.product.name //PB ep78 14mins
      qtyTextField.text = "\(currentItem.quantity)" //PB ep78 15mins
      priceLabel.text = currentItem.product.salePrice.currencyFormatter //PB ep78 15mins
   }
   
   
//MARK: IBActions
   @IBAction func removeButtonTapped(_ sender: Any) { //PB ep78 11mins
      if let product = item?.product, let itemIndexPath = itemIndexPath { //PB ep81  3mins check if there is a product in items array, and index path is not nil
         delegate?.confirmRemoval!(forProduct: product, itemIndexPath: itemIndexPath) //PB ep81 4mins this is how u call a method after we assign delegate and unwrap item
      }
   }
   
}



//MARK: TextField Delegate
extension ItemInCartTableViewCell: UITextFieldDelegate { //PB ep78 17mins
   func textFieldDidEndEditing(_ textField: UITextField) { //PB ep78 17mins
      if let qty = qtyTextField.text, let currentItem = self.item { //PB ep78 17mins check if textField's text is nil or not, and if we have an item to pass down
         shoppingCart.update(product: currentItem.product, quantity: Int(qty)!) //PB ep78 19mins call our cart's update method with our new value once textField ends editing
         delegate?.updateTotalCartItem() //PB ep81 15mins
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool { //PB ep78 19mins
      textField.resignFirstResponder() //PB ep78 20mins
      return true //PB ep78 20mins
   }
   
}
