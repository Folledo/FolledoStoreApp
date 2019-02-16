//
//  ReviewOrderTableViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/15/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class ReviewOrderTableViewController: UITableViewController { //PB ep94 20mins
   
//MARK: IBOutlets
   
   
   
//MARK: Properties
   var shoppingCart = ShoppingCart.sharedInstance //PB ep95 13mins
   weak var delegate: ShoppingCartDelegate? //PB ep95 28mins
   
   override func viewDidLoad() { //PB ep94 20mins
      super.viewDidLoad()
      
      tableView.register(UINib(nibName: "ItemInCartTableViewCell", bundle: nil), forCellReuseIdentifier: "itemInCartCell") //PB ep95 14mins register the cell so we can reuse it for this tableViewController
      tableView.tableFooterView = UIView() //PB ep95 30mins remove the additional line underneath the TVC
      
   }

// MARK: - Table view data source
   override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 6 //PB ep95 15mins return our 6 cells
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      switch section { //PB ep95 15mins
      case 0,2,3,4,5: //PB ep95 16mins
         return 1 //PB ep95 16mins
      case 1:
         return shoppingCart.items.count //PB ep95 16mins
      default: //PB ep95 15mins
         return 0
      }
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep95 17mins
      switch indexPath.section { //PB ep95 17mins
      case 0, 5: //PB ep95 18mins
         tableView.rowHeight = 60 //PB ep95 18mins
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "placeOrderCell", for: indexPath) //PB ep95 18mins
         return cell //PB ep95 19mins
         
      case 1: //PB ep95 19mins
         tableView.rowHeight = 80 //PB ep95 19mins
         
         let item = shoppingCart.items[indexPath.row] //PB ep95 19mins item we want to display, which is already in shoppingCart's items. get each by using indexPath.row
         let cell = tableView.dequeueReusableCell(withIdentifier: "itemInCartCell", for: indexPath) as! ItemInCartTableViewCell //PB ep95 20mins to reuse it, cast it as ItemInCartTVC
         cell.item = item //PB ep95 21mins
         cell.itemIndexPath = indexPath //PB ep95 21mins pass in the current indexPath that is focused
         cell.delegate = self //PB ep95 21mins
         
         return cell //PB ep95 22mins
         
      case 2: //PB ep95 22mins
         tableView.rowHeight = 60 //PB ep95 22mins
         
         let itemStr = shoppingCart.items.count == 1 ? "item" : "items" //PB ep95 23mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "orderTotalCell", for: indexPath) //PB ep95 23mins
         cell.textLabel?.text = "Subtotal \(shoppingCart.totalItem()) \(itemStr))" //PB ep95 24mins
         cell.detailTextLabel?.text = shoppingCart.totalItemCost().currencyFormatter //PB ep95 24mins
         return cell
         
      case 3: //PB ep95 25mins
         tableView.rowHeight = 135 //PB ep95 25mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell", for: indexPath) as! ShippingTableViewCell //PB ep95 25mins
         cell.configureCell() //PB ep95 26mins make cell configure itself
         return cell
      
      case 4: //PB ep95 26mins
         tableView.rowHeight = 70 //PB ep95 26mins
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTableViewCell //PB ep95 26mins
         cell.configureCell() //PB ep95 26mins configure itself
         return cell //PB ep95 26mins
         
      default: //PB ep95 17mins
         return UITableViewCell() //PB ep95 26mins
      }
      
   }

}



//MARK: ShoppingCart Delegate
extension ReviewOrderTableViewController: ShoppingCartDelegate {  //PB ep95 27mins copy pasted from CartTableVC's ShoppingCartDelegate extension
   func updateTotalCartItem() { //PB ep81 7mins
      delegate?.updateTotalCartItem() //PB ep95 27mins
      
      
      tableView.reloadData() //PB ep81 10mins we may completely remove a product thats in the cart so we reload tbView
   }
   
   
   func confirmRemoval(forProduct product: Product, itemIndexPath: IndexPath) { //PB ep95 27mins
      let alertController = UIAlertController(title: "Remove Item", message: "Remove \(String(describing: product.name?.uppercased())) from your shoppig cart?", preferredStyle: .actionSheet) //PB ep95 
      
      let removeAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] (action: UIAlertAction) in //PB ep95 27mins this remove action is going to be only executed if the user agree to remove the item.
         self?.shoppingCart.delete(product: product) //PB ep95 27mins call our shoppingCart's delete method
         self?.tableView.deleteRows(at: [itemIndexPath], with: UITableView.RowAnimation.fade) //PB ep95 27mins delete it from our table
         self?.tableView.reloadData() //PB ep95
         
         self?.updateTotalCartItem() //PB ep95 27mins update items in the cart itself
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //PB ep95 27mins
      
      alertController.addAction(removeAction)
      alertController.addAction(cancelAction)
      present(alertController, animated: true, completion: nil) //PB ep95 27mins
      
   }
   
}
