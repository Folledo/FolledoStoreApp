//
//  QuantityTableViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 12/6/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit //PB ep73 6mins


protocol QuantityPopoverDelegate: class { //PB ep74 1mins protocol for the quantityButton's popover controller //1mins with this class type protocol, we will be able to declare all of their properties inside the QuantityTableVC, which reduces the possibility of a strong reference cycle
   func updateProductToBuy(withQuantity quantity: Int) //PB ep74 2mins
}


class QuantityTableViewController: UITableViewController { //PB ep73 6mins
   
   var quantities = [1, 2, 3, 4, 5, 6, 7, 8, 9] //PB ep73 7mins
   weak var delegate: QuantityPopoverDelegate? //PB ep74 2mins reference to the delagate, now we need to make sure this delegate property get assigned by the controller that invoke this QuantityTVC
   
   
   
   override func viewDidLoad() { //PB ep73 6mins
      super.viewDidLoad()
   
   
   }

// MARK: - Table view data source
   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      return 2 //PB ep73 8mins 2 because we have 2 cells
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      switch section { //PB ep73 8mins
      case 0: //PB ep73 9mins first section has index 0
         return quantities.count //PB ep73 9mins
      case 1: //PB ep73 9mins if index is 1...
         return 1 //PB ep73 9mins this is the row that has 10+ which will summon a textfield
      default : //PB ep73 10mins
         return 0 //PB ep73 10mins
      }
   }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep73 10mins
      
      switch indexPath.section { //PB ep73 10mins switch between indexpath's sectionn
      case 0: //PB ep73 10mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "quantityCell", for: indexPath) //PB ep73 11mins now we have reference to our cell
         cell.textLabel?.text = "\(quantities[indexPath.row])" //PB ep73 11mins this will work since we have the basic style of cell
         return cell //PB ep73 12mins
         
      case 1: //PB ep73 10mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "tenPlusCell", for: indexPath) //PB ep73 12mins
         cell.textLabel?.text = "10+" //PB ep73 13mins
         return cell
         
      default: //PB ep73 10mins
         return UITableViewCell() //PB ep73 13mins
      }
   }
   
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //PB ep74 11mins
      switch indexPath.section { //PB ep74 11mins switch between sections
      case 0: //PB ep74 11mins first section (quantityCell 1-9), now we need to get the row being captured
         let selectedQuantity = quantities[indexPath.row] //PB ep74 12mins, we pass it in which indexPath we received either 1-9
         delegate?.updateProductToBuy(withQuantity: selectedQuantity) //PB ep74 12mins now call the delegate method to give the selectedQty
         dismiss(animated: true, completion: nil) //PB ep74 13mins after user selected, dismiss
         
      case 1: //PB ep74 14mins tenPlusCell section. When user select 10+, we want the user to put whatever quantity they want, so change that row to a textField
         let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell //PB ep74 14mins get reference to the cell
         cell.textLabel?.isHidden = true //PB ep74 15mins remove from the view, the textLabel itself
         let qtyTextField: UITextField = UITextField(frame: CGRect(x: (cell.contentView.frame.width - 60) / 2, y: (cell.contentView.frame.height - 30) / 2, width: 60.0, height: 30.0)) //PB ep74 15-18mins now we can add the textField to our cell //x: grabs the cell's contenView's width (= 100), subtract 60 for the TextField's width, divide by 2 in order to put it in the middle of the cell.
         qtyTextField.delegate = self //PB ep74 18mins when we enter some text inside TF, we need to tell this quantity TVcontroller, and we'll do something with the text itself //PB ep74 20mins dont forget to implement the delegate
         qtyTextField.font = UIFont.systemFont(ofSize: 15.0) //PB ep74 19mins
         qtyTextField.keyboardType = .numberPad //PB ep74 19mins
         qtyTextField.borderStyle = .roundedRect //PB ep74 19 mins
         
         cell.contentView.addSubview(qtyTextField) //PB ep74 20mins now add it to our cell's contentView, and add our TF
         cell.contentView.backgroundColor = .white //PB ep74 20mins
         
      default: //PB ep74 11mins
         break //PB ep74 11mins
      }
   }
}

//MARK: UITextField Delegate
extension QuantityTableViewController: UITextFieldDelegate { //PB ep74 21mins delegate to self on didSelect's case 1:
   func textFieldDidEndEditing(_ textField: UITextField) { //PB ep74 22mins when user is done entering a text, this method is called, where can capture the textfield's text
      if let qty = textField.text { //PB ep74 22mins get the tf's text
         delegate?.updateProductToBuy(withQuantity: Int(qty)!) //PB ep74 23mins call the delegate and update the qty
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool { //PB ep74 23mins asks the delegate if the tF should process the pressing of the return button
      textField.resignFirstResponder() //PB ep74 24mins gives control back to calling controller
      dismiss(animated: true, completion: nil) //PB ep74 24mins
      return true //PB ep74 14mins
   }
   
}

