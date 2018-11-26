//
//  ProductsTableViewCell.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/24/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell { //PB ep63 9mins
   
   
   @IBOutlet weak var productImageView: UIImageView! //PB ep63 9mins
   
   @IBOutlet weak var productNameLabel: UILabel! //PB ep63 9mins
   @IBOutlet weak var manufacturerLabel: UILabel! //PB ep63 9mins
   @IBOutlet weak var priceLabel: UILabel! //PB ep63 9mins
   
   @IBOutlet weak var userRating: UserRating! //PB ep65 17mins
   
   
   override func awakeFromNib() { //PB ep63
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(_ selected: Bool, animated: Bool) { //PB ep63
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
   
   
   internal func configureCell(with product: Product) { //PB ep63 13mins
      productImageView.image = Utility.image(withName: product.mainImage, andType: "png") //PB ep63 13mins
      productNameLabel.text = product.name //PB ep63 13mins
      manufacturerLabel.text = product.manufacturer?.name //PB ep63 13mins this is possible because we have the relationship between product entity and manufacturer entity
      priceLabel.text = "\(product.salePrice.currencyFormatter)" //PB ep63 13mins currencyFormatter is a Double extension we created
      
      userRating.rating = Int(product.rating) //PB ep65 18mins rating from coredata has a type of int16, and rating we set in userRAting is integer
   }
   
}
