//
//  PaymentViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 1/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController { //PB ep89 30mins
   
//MARK: IBOutlets
   @IBOutlet var mainView: UIView!
   @IBOutlet weak var paymentTableView: UITableView! //PB ep93 0mins
   
   
//MARK: Properties
   var customer: Customer? //PB ep90 23mins
   var creditCards = [CreditCard]() //PB ep93 1mins var with a type of CreditCard array, so we can capture which cards is referenced to this Customer
   var shoppingCart = ShoppingCart.sharedInstance //PB ep93 2mins
   var popInfoType: PopInfoType? //PB ep93 2mins enum with expMonth and expYear cases
   var selectedIndexPath: IndexPath? //PB ep93 3mins this property is to capture which credit card is selected by the customer to make the payment. We'll want to keep track which IndexPath is being used
   
   override func viewDidLoad() { //PB ep89 30mins
      super.viewDidLoad()

      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      self.mainView.addGestureRecognizer(tap)
      
      
      if let customer = customer { //PB ep93 4mins unwrap the customer first
         let creditCardSet = customer.creditCard?.mutableCopy() as! NSMutableSet //PB ep93 5mins since customer can have multiple creditCards, meaning one-to-many relationship, thats why the datatype is NSSet. Remember to convert it to mutable set so we can array it, as well as convert it back to NSSet
         if creditCardSet.count > 0 { //PB ep93 5mins if we have creditcard...
            creditCards = creditCardSet.allObjects as! [CreditCard] //PB ep93 6mins convert this creditCardSet into an array and store it in self.creditCards, this is how you do it
         }
      }
      
   }
   
   
   @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      self.view.endEditing(true)
   }
   
//MARK: IBActions
   
   @IBAction func expMonthButtonTapped(_ sender: MyButton) { //PB ep93 7mins
      popInfoType = PopInfoType.expMonth //PB ep93 18mins
      showPopoverInfo(forSender: sender) //PB ep93 19mins
   }
   
   @IBAction func expYearButtonTapped(_ sender: MyButton) { //PB ep93 7mins
      popInfoType = PopInfoType.expYear //PB ep93 20mins
      showPopoverInfo(forSender: sender) //PB ep93 20mins
   }
   
}








//MARK: UITableView DataSource and Delegate
extension PaymentViewController: UITableViewDataSource, UITableViewDelegate { //PB ep93 20mins
   func numberOfSections(in tableView: UITableView) -> Int { //PB ep93 21mins
      return 4 //PB ep93 22mins we have 4 cells
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //PB ep93 22mins
      switch section { //PB ep93 22mins
      case 0, 2, 3: //PB ep93 23mins
         return 1 //PB ep93 23mins cell 0, 2 and 3 only needs one row
      case 1: //PB ep93 23mins this cell contains the creditCards
         let rowCount: Int = creditCards.count > 0 ? creditCards.count : 1 //PB ep93 23mins rowCount will be either 1 or creditCards.count
         return rowCount
      default: //PB ep93 23mins
         return 0 //PB ep93 24mins
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep93 24mins
      switch indexPath.section { //PB ep93 25mins
      case 0:
         tableView.rowHeight = 30 //PB ep93 43mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) //PB ep93 26mins
         return cell //PB ep93 26mins
      case 1:
         tableView.rowHeight = 30 //PB ep93 43mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! ExistingCreditCardTableViewCell //PB ep93 27mins
         cell.accessoryType = .none //PB ep93 27mins remove any checkmarks
         
         let isCreditCardOnRecord = self.creditCards.count > 0 ? true : false //PB ep93 28mins if customer has creditCards then set it to true, else false
         cell.noCreditCardLabel.isHidden = isCreditCardOnRecord //PB ep93 29mins hide this label if isCreditCardOnRecord is true (meaning customer has credit card on record)
         cell.cardTypeImageView.isHidden = !isCreditCardOnRecord //PB ep93 29mins reverse the value of isCreditCardOnRecord
         cell.cardNumberLabel.isHidden = !isCreditCardOnRecord //PB ep93 30mins
         cell.nameOnCardLabel.isHidden = !isCreditCardOnRecord //PB ep93 30mins
         cell.expirationLabel.isHidden = !isCreditCardOnRecord //PB ep93 30mins
         
         if isCreditCardOnRecord == true { //PB ep93 31mins if customer does have credit card, then display that credit card info
            let creditCard = self.creditCards[indexPath.row] //PB ep93 31mins get the creditCard information from the array
             //PB ep93 31mins pass in this credit card info to the existing credit card TVC
            cell.configureCell(withCreditCard: creditCard) //PB ep93 31mins call our configureCell function and pass in our credit card
            
            if self.creditCards[indexPath.row] == shoppingCart.creditCard { //PB ep93 36mins meaning the current indexPath thats in focus is equal to shoppingCart creditCard then put checkMark
               cell.accessoryType = .checkmark //PB ep93 37mins
               selectedIndexPath = indexPath //PB ep93 37mins
            }
         }
         return cell //PB ep93 32mins

      case 2:
         tableView.rowHeight = 50 //PB ep93 43mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "addCardTitleCell", for: indexPath) //PB ep93 32mins
         return cell //PB ep93 32mins
      case 3:
         tableView.rowHeight = 100 //PB ep93 43mins
         let cell = tableView.dequeueReusableCell(withIdentifier: "addCardCell", for: indexPath) as! NewCreditCardTableViewCell //PB ep93 32mins
         cell.customer = customer //PB ep93 33mins because we opened this NewCreditCardTVC we need to pass in this customer object because we need to use this customer object to pass in when we add the credit card in this customer,meaning this is to associate the new card with the customer
         cell.creditCardDelegate = self //PB ep93 4mins dont forget to implement in the extension
         return cell //PB ep93 33mins
      default: //PB ep93 25mins
         return UITableViewCell() //PB ep93 25mins
      }
   }
   //PB ep93 20mins
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //PB ep93 37mins detect if there is multiple credit card and select one of them. We need to know which one was selected and we'll put a checkmark on the selected card, and also assign that credit card to the shopping cart
      switch indexPath.section { //PB ep93 38mins
      case 1: //PB ep93 38mins
         if self.creditCards.count > 0 { //PB ep93 38mins check if we have creditCards in our array
            shoppingCart.creditCard = self.creditCards[indexPath.row] //PB ep93 39mins then attach the credit card selected to our shopping cart
            
            if selectedIndexPath != nil && selectedIndexPath != indexPath { //PB ep93 39mins check if there is a credit card that already selected previously and we want to change to a different card
               paymentTableView.cellForRow(at: selectedIndexPath!)?.accessoryType = .none //PB ep93 40mins remove the checkmark like this //PB ep93 40mins because if the selectedIndexPath does not match with indexPath, that means that it is not the card selected and we want to remove the checkmark
               selectedIndexPath = indexPath //PB ep93 40mins set the new selectedIndexPath
            }
            paymentTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //PB ep93 41mins
         }
         
      default: //PB ep93 38mins
         break //PB ep93 38mins
      }
   }
}

//MARK: UIPopoverPresentationControllerDelegate
extension PaymentViewController:UIPopoverPresentationControllerDelegate { //PB ep93 9mins
   internal func showPopoverInfo(forSender sender: UIButton) { //PB ep93 10mins
      let navController = storyboard?.instantiateViewController(withIdentifier: "navPopover") as! UINavigationController //PB ep93 11mins
      navController.modalPresentationStyle = .popover //PB ep93 11mins transition style of this navController popOver effect
      
      let popoverTVC = navController.topViewController as! PopoverTableViewController //PB ep93 11mins reference of our TVC itself. Now we can set the type, title, sender, and delegate as well
      popoverTVC.popInfoType = popInfoType //PB ep93 12mins
      popoverTVC.title = popInfoType?.rawValue //PB ep93 13mins title
      popoverTVC.sender = sender //PB ep93 13mins it needs the source in order to know which button called this popover
      popoverTVC.delegate = self //PB ep93 14mins Don't forget to implement this delegate function
      
      let popOverController = navController.popoverPresentationController //PB ep93 14mins .popoverPresentationController = The nearest popover presentation controller that is managing the current view controller.
      popOverController?.sourceView = sender //PB ep93 15mins sender can either expMonth or expYear button
      popOverController?.sourceRect = sender.bounds //PB ep93 15mins
      popOverController?.permittedArrowDirections = .any //PB ep93 16mins .permittedArrowDirections = The arrow directions that you allow for the popover.
      popOverController?.delegate = self //PB ep93 17mins
      
      present(navController, animated: true, completion: nil) //PB ep93 17mins now present it
   }
}

//MARK: PopInfoSelection Delegate
extension PaymentViewController: PopInfoSelectionDelegate { //PB ep93 17mins
   func updateWithPopInfoSelection(value: String, sender: UIButton) { //PB ep93 18mins
      sender.setTitle(value, for: .normal) //PB ep93 18mins title itself will come from value
   }
}

//MARK: CreditCard Delegate
extension PaymentViewController: CreditCardDelegate { //PB ep93 34mins from self's cellForRowAt for the tableView's cell 3
   func add(card: CreditCard) { //PB ep93 34mins assign this new card to our shopping cart, meaning we can assume that the credit card the customer just inputted is what theyll use to pay
      self.shoppingCart.creditCard = card //PB ep93 35mins the card passed to this function will now be the shoppingCart's creditCard
      self.creditCards.append(card) //PB ep93 35mins append it to out array
      
      self.paymentTableView.reloadData() //PB ep93 35mins reload it so it will show in the tableView's cell #1 so it will display as well, we will also need to put a checkmark on it
   }
}
