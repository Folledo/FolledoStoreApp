//
//  PaymentTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/15/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell { //PB ep94 21mins
   
//MARK: IBOutlets
   @IBOutlet weak var cardImageView: UIImageView! //PB ep95 8mins
   @IBOutlet weak var cardNumberLabel: UILabel! //PB ep95 8mins
   @IBOutlet weak var nameOnCardLabel: UILabel! //PB ep95 8mins
   @IBOutlet weak var expirationLabel: UILabel! //PB ep95 8mins
   
   //MARK: Properties
   let shoppingCart = ShoppingCart.sharedInstance //PB ep95 8mins
   
   override func awakeFromNib() { //PB ep94 21mins
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) { //PB ep94 21mins
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
   
   internal func configureCell() { //PB ep95 9mins
      if let creditCard = shoppingCart.creditCard { //PB ep95 10mins
         let cardType:String = creditCard.type! //PB ep95 10mins
         
         cardImageView.image = UIImage(named: "\(cardType)") //PB ep95 10mins
         cardNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4() //PB ep95 11mins
         nameOnCardLabel.text = creditCard.nameOnCard //PB ep95 12mins
         expirationLabel.text = "\(creditCard.expMonth)/\(creditCard.expYear)" //PB ep95 12mins
      }
   }
   
}
