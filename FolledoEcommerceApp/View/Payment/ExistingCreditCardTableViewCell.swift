//
//  ExistingCreditCardTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/2/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class ExistingCreditCardTableViewCell: UITableViewCell { //PB ep91 1mins
   
//MARK: IBOutlets
   @IBOutlet weak var cardTypeImageView: UIImageView! //PB ep91 3mins
   @IBOutlet weak var cardNumberLabel: UILabel! //PB ep91 3mins
   @IBOutlet weak var nameOnCardLabel: UILabel! //PB ep91 3mins
   @IBOutlet weak var expirationLabel: UILabel! //PB ep91 3mins
   @IBOutlet weak var noCreditCardLabel: UILabel! //PB ep91 4mins
   
   
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
   }
   
   
   internal func configureCell(withCreditCard creditCard: CreditCard) { //PB ep91 5mins
      noCreditCardLabel.isHidden = true //PB ep91 6mins
      cardNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4() //PB ep91 6mins, but we need to mask this to only show the last 4 digits. We created that method in String extensions
	let cardType:String = creditCard.type!
	cardTypeImageView.image = UIImage(named: "\(cardType)") //PB ep91 10mins
      print(creditCard.type!)
      
      nameOnCardLabel.text = creditCard.nameOnCard //PB ep91 10mins
      expirationLabel.text = "\(creditCard.expMonth)/\(creditCard.expYear)" //PB ep91 11mins
      
   }
   
}
