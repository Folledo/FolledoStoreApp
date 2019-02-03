

//
//  CustomerViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 1/20/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController { //PB ep85 17mins
   
//MARK: IBOutlets
   @IBOutlet weak var nameTextField: UITextField! //PB ep85 21mins
   @IBOutlet weak var emailTextField: UITextField! //PB ep85 21mins
   @IBOutlet weak var passwordTextField: UITextField! //PB ep85 21mins
   @IBOutlet var mainView: UIView!
   
   
   override func viewDidLoad() { //PB ep85 17mins
      super.viewDidLoad()

      let navBack = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil) //PB ep85 22mins this is to remove the navigation provided
      self.navigationItem.leftBarButtonItem = navBack //PB ep85 23mins
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      self.mainView.addGestureRecognizer(tap)
   }
   
   
   @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      self.view.endEditing(true)
   }
   
//MARK: Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //PB ep85 23mins
      if let identifier = segue.identifier { //PB ep85 23mins
         switch identifier { //PB ep85 24mins
         case "addAddressSegue":
            guard let name = nameTextField.text, name.count > 0,
                  let email = emailTextField.text, email.count > 0,
                  let password = passwordTextField.text, !password.isEmpty else { //PB ep85 28mins unwrap textfields and make sure the chars are greater than 0 or not isEmpty
                  
               let alert = UIAlertController(title: "Missing information", message: "Please provide all the information for name, email, and password", preferredStyle: .alert) //PB ep85 29mins
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil) //PB ep85 30mins
               alert.addAction(okAction) //PB ep85 30mins
               present(alert, animated: true, completion: nil) //PB ep85 30mins
               return //PB ep85 31mins
            }
            let customer = CustomerService.addCustomer(name: name, email: email, password: password) //PB ep85 31mins call our addCustomer method
            let addressController = segue.destination as! AddressViewController //PB ep85 31mins once we have the customer, we want to set the destination of the controller
            addressController.customer = customer //PB ep85 32mins
            
         default: //PB ep85 24mins
            break //PB ep85 24mins
         }
      }
   }
   
   @IBAction func createButtonTapped(_ sender: MyButton) {
      
   }
   
   
}
