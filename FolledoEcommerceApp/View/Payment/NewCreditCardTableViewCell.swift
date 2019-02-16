//
//  NewCreditCardTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/2/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

enum CreditCardType: String { //PB ep91 14mins enum which will identify the card type the customer is using
   case Visa = "visa" //PB ep91 14mins
   case MC = "mastercard" //PB ep91 15mins
   case Amex = "amex" //PB ep91 15mins
   case Discover = "discover" //PB ep91 15mins
   case Unknown = "unknown" //PB ep91 15mins
}

protocol CreditCardDelegate: class { //PB ep91 28mins, when we're updating the paymentVC, this delegate will be implemented by paymentVC
   func add(card: CreditCard) //PB ep91 29mins
}


class NewCreditCardTableViewCell: UITableViewCell { //PB ep91 1mins
   
//MARK: IBOutlets
   @IBOutlet weak var nameOnCardTextField: UITextField! //PB ep91 12mins
   @IBOutlet weak var cardNumberTextField: UITextField! //PB ep91 13mins
   @IBOutlet weak var expMonthButton: MyButton! //PB ep91 13mins
   @IBOutlet weak var expYearButton: MyButton! //PB ep91 13mins
   
   
//MARK: Properties
   var customer: Customer? //PB ep91 27mins
   weak var creditCardDelegate: CreditCardDelegate? //PB ep91 30mins, now we can use this delegate to pass in the creditCardInfo tht we just captured in addCardButton
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   
   
//MARK: IBActions
   @IBAction func addCardTapped(_ sender: Any) { //PB ep91 13mins
      guard let nameOnCard = nameOnCardTextField.text, let cardNumber = cardNumberTextField.text, let expMonth = Int16((expMonthButton.titleLabel?.text)!), let expYear = Int16((expYearButton.titleLabel?.text)!) else { return } //PB ep91 26mins unwrap
      
      let creditCard = CustomerService.addCreditCard(forCustomer: self.customer!, nameOnCard: nameOnCard, cardNumber: cardNumber, expMonth: Int(expMonth), expYear: Int(expYear)) //PB ep91 27mins
     
      //if customer entering a new card and then when they tap the addCartButton, we want to select the new card as the default to pay the shoppingCart.items. And communicate back this creditcard info to the paymentViewController, using a delegate
      creditCardDelegate?.add(card: creditCard) //PB ep91 30mins pass in the creditCard
      
      //Reset Credit Card Info
      nameOnCardTextField.text = "" //PB ep91 31mins
      cardNumberTextField.text = "" //PB ep91 31mins
      expMonthButton.setTitle("\(Utility.currentMonth())", for: .normal) //PB ep91 32mins
      expYearButton.setTitle("\(Utility.currentYear())", for: .normal) //PB ep91 32mins we will get the current year from the calendar
   }
}
