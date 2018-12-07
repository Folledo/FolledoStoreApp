//
//  ProductInfoTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 12/4/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell { //PB ep71 the rest of 71 is designing UI of bottom details
   
   
//MARK: IBOutlets
   
   
   @IBOutlet weak var infoTitleLabel: UILabel!
   
   @IBOutlet weak var productSpecLabel: UILabel!
   
   
   
   
//MARK: Properties //PB ep72
   var productInfo: ProductInfo? { //PB ep72 15mins
      didSet { //PB ep72 16mins changed to a computed property so configureCell will be called whenever we set productInfo's value
         if let currentInfo = productInfo { //PB ep72 16mins if not nil...
            configureCell(with: currentInfo) //PB ep72 16mins
         }
      }
   }
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
   
   
   
   private func configureCell(with productInfo: ProductInfo) { //PB ep72 15mins//instead of being called from DetailVC, we'll have this method called whenever the productInfo is being set. Done by turning productInfo into a didSet computed property
      infoTitleLabel.text = productInfo.title //PB ep72 17mins with the right product, we can set the label's texts and we can go back to cellForRowAt
      productSpecLabel.text = productInfo.info //PB ep72 17mins
      
      
   }
   
}
