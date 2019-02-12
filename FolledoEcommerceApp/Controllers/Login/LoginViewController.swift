//
//  LoginViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 1/15/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController { //PB ep82 
   
//MARK: IBOutlets
   @IBOutlet weak var emailTextField: UITextField! //PB ep82
   @IBOutlet weak var passwordTextField: UITextField! //PB ep82
   
   @IBOutlet var mainView: UIView!
   
//MARK: Properties
   var customer: Customer? //PB ep84 7mins
   
   
   
   override func viewDidLoad() { //PB ep82
      super.viewDidLoad()

      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      self.mainView.addGestureRecognizer(tap)
   }
   
   
   @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      self.view.endEditing(true)
   }
   
//MARK: Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let identifier = segue.identifier { //PB ep84 16mins get the identifier
         switch identifier { //PB ep84 16mins
         case "shipAddressSegue": //PB ep84 17mins
            let addressVC = segue.destination as! AddressViewController //PB ep84 18mins, now we can pass the customer
            addressVC.customer = customer //PB ep84 19mins
         default: //PB ep84 17mins
            break //PB ep84 19mins
         }
      }
   }
   
//MARK: IBActions
   @IBAction func signinButtonTapped(_ sender: MyButton) { //PB ep82
      guard let email = emailTextField.text, let password = passwordTextField.text else { return } //PB ep84 8mins check if fields have values
      
      customer = CustomerService.verify(username: email.trimmedString(), password: password.trimmedString()) //PB ep84 9mins now we verify. Customer object can be a real customer entity, if it cannot be found then return nil
      
      if customer != nil { //PB ep84 10mins if we have a customer...
         
         performSegue(withIdentifier: "shipAddressSegue", sender: self) //PB ep84 15mins if we have a customer then go to shipping address 
         
         
      } else { //PB ep84 10mins if customer is nil
         let alertController = UIAlertController(title: "Login failed", message: "We do not recognize your email and/or password. \nPlease try again.", preferredStyle: .alert) //PB ep84 10mins
         
         let okAction = UIAlertAction(title: "OK", style: .default) { (action) in //PB ep84 11mins
            DispatchQueue.main.async { [weak self] in //PB ep84 12mins if log in failed for this OK action, we're going to clear email and password textField. We can access main thread by usong dispatch
               self?.emailTextField.text = "" //PB ep84 13mins
               self?.passwordTextField.text = "" //PB ep84 13mins
            }
         }
         alertController.addAction(okAction) //PB ep84 13mins
         present(alertController, animated: true, completion: nil) //PB ep84 13mins
      }
      
   }
   
   @IBAction func createButtonTapped(_ sender: MyButton) { //PB ep82
      performSegue(withIdentifier: "registerSegue", sender: nil)
   }
   
   @IBAction func cancelButtonTapped(_ sender: Any) { //PB ep82
      self.dismiss(animated: true, completion: nil) //PB ep84 8mins
   }
   
   @IBAction func unwindFromCreateAccount(segue: UIStoryboardSegue) { //PB ep85 14mins for unwind segue. This special IBAction will allow us to create an exit from self back to LoginVC. We can connect this segue by control dragging from Register's Signin Button to its Exit (3rd icon on the top of the controller)
      print("Back from create account scene") //PB ep85 14mins
      
   }
   
}
