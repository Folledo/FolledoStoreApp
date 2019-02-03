//
//  CartTableViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 12/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController { //PB ep78 6mins
   
//MARK: IBOutlets
   @IBOutlet weak var checkoutButton: UIBarButtonItem! //PB ep78 8mins
   
   
//MARK: Properties
   var shoppingCart = ShoppingCart.sharedInstance //PB ep78 9mins get the singleton sharedInstance
   weak var cartDelegate: ShoppingCartDelegate? //PB ep81 8mins
   
   
   override func viewDidLoad() { //PB ep78 6mins
      super.viewDidLoad()
      
      tableView.register(UINib(nibName: "ItemInCartTableViewCell", bundle: nil), forCellReuseIdentifier: "cellItemInCart") //PB ep78 20mins we need to initiate the XIB file, so we can use it in our TVC //PB ep78 21mins register it with the same name as the file and nil bundle. with the id
      
   }
   
   override func viewWillAppear(_ animated: Bool) { //PB ep78 10mins this method guarantees everytime the view is shown to the user, this method is executed
      super.viewWillAppear(animated) //PB ep78 10mins
      checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false //PB ep78 11mins enable the checkout button if cart's item is greater than 0, else disable it
      
   }
   
   
// MARK: - Table view data source
   override func numberOfSections(in tableView: UITableView) -> Int { //PB ep78 11mins
      return 2 //PB ep78 11mins
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //PB ep78 11mins
      
      switch section { //PB ep78 11mins
      case 0: //PB ep78 11mins
         return shoppingCart.items.count //PB ep78 12mins return the count of our cart's items array
         
      case 1: //PB ep78 11mins
         return 1 //PB ep78 12 mins second section returns 1 row
         
      default: //PB ep78 11mins
         return 0 //PB ep78 12mins if nothing is found then return 0
      }
   } //PB ep78 11mins end of numberOfRows
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep78 22mins
      let section = indexPath.section //PB ep78 22mins
      switch section { //PB ep78 22mins
      case 0: //PB ep78 22mins
         tableView.rowHeight = 70 //PB ep78 22mins assign the height same as what we have in the xib
         let item = shoppingCart.items[indexPath.row] //PB ep78 23mins, this will be item that will be displayed in each individual cell
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellItemInCart", for: indexPath) as! ItemInCartTableViewCell //PB ep78 23-24mins after we get the item, initiate our cell
         cell.item = item //PB ep78 24mins pass the cell's item to be our item
         cell.itemIndexPath = indexPath
         
         cell.delegate = self //PB ep81 6mins now we implement that method
         return cell
         
      case 1: //PB ep78 26mins section index 1
         tableView.rowHeight = 40 //PB ep78 26mins
         //Subtotal (xx items) .... $$$
         let itemStr = shoppingCart.items.count == 1 ? "item" : "items" //PB ep78 27mins //PB ep78 26mins get quantity associated with the product in the cell
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellSummary", for: indexPath) //PB ep78 28mins cellSummary is cell's identif in storyboard. Since we a using the basic right detail, we do not need to subclass the cell
         cell.textLabel?.text = "Subtotal (\(shoppingCart.totalItem()) \(itemStr))" //PB ep78 29mins
         cell.detailTextLabel?.text = shoppingCart.totalItemCost().currencyFormatter //PB ep78 29mins detailTextLabel is the text on the right side of the cell, this will have the total cost with our currencyFormatter method
         return cell //PB ep78 29mins
         
      default: //PB ep78 22mins
         return UITableViewCell() //PB ep78 29mins
      }
   }
   
   
//MARK: TableView Delegate
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { //PB ep78 13mins
      switch section{ //PB ep78 13mins
      case 0: //PB ep78 13mins
         return "Review Items" //PB ep78 14mins
//      case 1: //PB ep78 13mins not needed as we dont want a header for it
      default: //PB ep78 13mins
         return "" //PB ep78 14mins
      }
   }
   
   
   
   
   
   
//MARK: IBActions
   @IBAction func continueShoppingTapped(_ sender: Any) { //PB ep78 8mins
      dismiss(animated: true, completion: nil) //PB ep78 9mins
   }
   
   
}


//MARK: ShoppingCart Delegate
extension CartTableViewController: ShoppingCartDelegate { //PB ep81 6-8mins we have this cell, itemInCartTableViewCell, which lives inside the CartTVC, which is why we set the delegate for this cell to be the controller itself. Now from this controller, we need to tell the ProductDetailController that an item has been updated. To do that, first we need to set the delegate from this cell to the ShoppingCart, and now we also need to set the delegate for this ShoppingCart to the ProductDetail, 2 step delegate
   func updateTotalCartItem() { //PB ep81 7mins
      cartDelegate?.updateTotalCartItem() //PB ep81 9mins invoke that cart delegate. Then we call the same function which will be handled by the ProductDetailVC. //Invoke delegate in ProductDetailViewController to update the number of item in cart
      
      checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false //PB ep81 10mins
      tableView.reloadData() //PB ep81 10mins we may completely remove a product thats in the cart so we reload tbView
   }
   
   
   func confirmRemoval(forProduct product: Product, itemIndexPath: IndexPath) { //PB ep81 10mins whenever user wants to remove something, we will have to make them confirm so they dont remove something by accident
      let alertController = UIAlertController(title: "Remove Item", message: "Remove \(String(describing: product.name?.uppercased())) from your shoppig cart?", preferredStyle: .actionSheet) //PB ep81 11mins
      
      let removeAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] (action: UIAlertAction) in //PB ep81 12-13mins this remove action is going to be only executed if the user agree to remove the item.
         self?.shoppingCart.delete(product: product) //PB ep81 13mins call our shoppingCart's delete method
         self?.tableView.deleteRows(at: [itemIndexPath], with: UITableView.RowAnimation.fade) //PB ep81 14mins delete it from our table
         self?.tableView.reloadData() //PB ep81 15mins refresh
         
         self?.updateTotalCartItem() //PB ep81 15mins update items in the cart itself
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //PB ep81 16mins do nothing
      
      alertController.addAction(removeAction) //PB ep81 16mins
      alertController.addAction(cancelAction) //PB ep81 16mins
      present(alertController, animated: true, completion: nil) //PB ep81 16mins dont forget to implement the delegate in the productDetailViewController, to handle updateTotalCartItem
      
   }
   
}
