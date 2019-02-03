//
//  AddressViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 1/20/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController { //PB ep84 17mins
   
//MARK: IBOutlets
   @IBOutlet weak var scrollView: UIScrollView! //PB ep86 10mins
   @IBOutlet weak var addressPickerView: UIPickerView! //PB ep86 10mins
   
   @IBOutlet weak var fullNameTextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var address1TextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var address2TextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var cityTextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var stateTextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var zipTextField: UITextField! //PB ep86 10mins
   @IBOutlet weak var phoneTextField: UITextField! //PB ep86 10mins
   
   @IBOutlet weak var noAddressLabel: UILabel! //PB ep86 11mins
   @IBOutlet weak var mainView: UIView!
   
   
   
//MARK: Properties
   var customer: Customer? //PB ep84 19mins
   var addresses = [Address]() //PB ep87 3mins array of Address
   var selectedAddress: Address? //PB ep87 7mins property for the selectedAddress from pickerView
   var activeTextField: UITextField? //PB ep88 0mins
   var shoppingCart = ShoppingCart.sharedInstance //PB ep90 13mins cart singleton reference
   
   
   
//MARK: LifeCycle
   override func viewDidLoad() { //PB ep84 17mins
      super.viewDidLoad()

      
      registerForKeyboardNotification()
      
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      self.mainView.addGestureRecognizer(tap)
   }
   
   override func viewWillAppear(_ animated: Bool) { //PB ep87 11mins
      super.viewWillAppear(animated) //PB ep87 11mins
      
      addressPickerView.isHidden = false //PB ep87 12mins set the default value for addressPickerView and noAddressLabel
      noAddressLabel.isHidden = true //PB ep87 12mins
      
      if let customer = customer { //PB ep87 13mins if customer is not nil, then get the address for this customer and put it in addresses Array to insert in our pickerView. If no address then show no addressLabel
         addresses = CustomerService.addressList(forCustomer: customer) //PB ep87 13mins call our showAddress method and put it in our addresses Array
         
         if addresses.count == 0 { //PB ep87 13mins if customer has no address on record yet...
            addressPickerView.isHidden = true //PB ep87 14mins
            noAddressLabel.isHidden = false //PB ep87 14mins
         }
      }
   }
   
//MARK: NAvigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //PB ep90 0mins
      if let identifier = segue.identifier { //PB ep90 0mins
         switch identifier { //PB ep90 1mins
         case "paymentSegue": //PB ep90 address to payment controller segue
            
            if let customer = customer { //PB ep90 2mins unwrap customer. If customer is not nil, then we'll assign this shopping cart we have to this particular customer
               shoppingCart.assignCart(toCustomer: customer) //PB ep90 14min
               
               var address: Address //PB ep90 14mins var for Address
               if !(address1TextField.text?.isEmpty)! { //PB ep90 15mins unwrap the textField
                  guard let address1 = address1TextField.text, let city = cityTextField.text, let state = stateTextField.text, let zip = zipTextField.text, let phone = phoneTextField.text else { return }
                  var address2 = " "
                  if address2TextField.text == "" || (address2TextField.text?.isEmpty)! {
                     address2 = ""
                  }
                  
                  address = CustomerService.addAddress(forCustomer: customer, address1: address1, address2: address2, city: city, state: state, zip: zip, phone: phone) //PB ep90 16mins call our addAddress method
                  
                  shoppingCart.assignShipping(address: address) //PB ep90 17mins pass the address
                  
               } else { //PB ep90 17mins if text fields are empty, check if customer already has an address on the pickerView or not
                  if selectedAddress == nil { //PB ep90 19mins check if selectedAddress is nil. Meaning if customer has some address in the pickerView but they havenet made a selection
                     selectedAddress = addresses[self.addressPickerView.selectedRow(inComponent: 0)] //PB ep90 20mins pick the first address on the pickerView and store it in the selectedAddress. First item is index 0
                  }
                  shoppingCart.assignShipping(address: selectedAddress!) //PB ep90 21mins
                  
               }
               let paymentController = segue.destination as! PaymentViewController //PB ep90 23mins destination controller
               paymentController.customer = customer //PB ep90 24mins
            }
            
         default: //PB ep90 1mins
            break //PB ep90 1mins
         }
      }
   }
   
   
//MARK: Private functions
   private func registerForKeyboardNotification() { //PB ep88 1mins this func, we create a notification and add the observer for that notification. And this observer is going to get the notification when the keyboard shows up or disappears
      let notificationCenter = NotificationCenter.default //PB ep88 2mins .default = The app’s default notification center.
      
      notificationCenter.addObserver(self, selector: #selector(AddressViewController.keyboardIsOn(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil) //PB ep88 2mins addObserver with our method
      notificationCenter.addObserver(self, selector: #selector(AddressViewController.keyboardIsOff(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil) //PB ep88 5mins this adds the observer for the keyboard notification named keyboardWillHide
      
   }
   
   @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
      self.view.endEditing(true)
   }
   
   @objc private func keyboardIsOn(sender: Notification) { //PB ep88 3mins
   //get the height, we need few steps
      let info: NSDictionary = sender.userInfo! as NSDictionary //PB ep88 6mins get the sender's userInfo
      let value: NSValue = info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue //PB ep88 6mins get the value and pass in the key
      let keyboardSize = value.cgRectValue.size //PB ep88 7mins with value, now we can get the keyboard size
      print(keyboardSize.height)
   //PB ep88 7mins now we need the content inset based on these keyboard size
      let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0) //PB ep88 8mins create the inset and put keyboardSize at the bottom
      scrollView.contentInset = contentInsets //PB ep88 8mins
      scrollView.scrollIndicatorInsets = contentInsets //PB ep88 8mins
   }
   
   @objc private func keyboardIsOff(sender: Notification) { //PB ep88 3mins
      scrollView.setContentOffset(CGPoint(x: 0, y: -50), animated: true) //PB ep88 8mins setContentOffset = Sets the offset from the content view’s origin that corresponds to the receiver’s origin.
      scrollView.isScrollEnabled = true //PB ep88 9mins
   }
   
}


//MARK: UIPicker DataSource and Delegate
extension AddressViewController: UIPickerViewDataSource, UIPickerViewDelegate { //PB ep87 3mins
   func numberOfComponents(in pickerView: UIPickerView) -> Int { //PB ep87 4mins
      return 1 //PB ep87 4mins
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //PB ep87 4mins
      return addresses.count //PB ep87 5mins
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //PB ep87 5mins this will determine what we see in the pickerView
      let address = addresses[row] //PB ep87 6mins get each address from addresses
      
      return "\(address.address1!) \(address.address2!), \(address.city!), \(address.state!) \(address.zip!)" //PB ep87 7mins
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { //PB ep87 7mins
      selectedAddress = addresses[row] //PB ep87 8mins
   }
}


//MARK: UITextField Delegate
extension AddressViewController: UITextFieldDelegate { //PB ep88 10mins
   func textFieldDidBeginEditing(_ textField: UITextField) { //PB ep88 10mins this method will be invoke whenever we tap on a textField. if we tap on fullNameTextField, this textField in the parameter will point to that particular fullNameTextField, which we can point to activeTextField property
      activeTextField = textField //PB ep88 11mins
      scrollView.isScrollEnabled = true //PB ep88 11mins enable it so we can move it up
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool { //PB ep88 11mins this method is invoke whenever we tap return from the textField
      textField.resignFirstResponder() //PB ep88 11mins
      activeTextField = nil //PB ep88 11mins
      
      return true //PB ep88 12mins
   }
   
}
