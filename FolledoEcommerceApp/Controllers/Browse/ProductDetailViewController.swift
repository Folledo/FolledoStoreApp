//
//  ProductDetailViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/26/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController { //PB ep68 0mins
   
   
//MARK: IBOutlet
   @IBOutlet weak var detailSummaryView: DetailSummaryView! //PB ep68 2mins contentView
   
   
//MARK: Properties
   var product: Product? { //PB ep68 11mins so we're going to initiate the update of the detail summary view whenever a product has been set. In order to do that, we need a computed property with didSet
      didSet { //PB ep68 11mins
         if let currentProduct = product { //PB ep68 12mins check if product is nil or not. If product is not nil, then we pass in that product to the detailSummaryView
            self.showDetail(for: currentProduct) //PB ep68 14mins
         }
      }
      
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   
   }
   
   
//MARK: Private
   private func showDetail(for currentProduct: Product) { //PB ep68 12mins before we load the product into the detailSummaryView, we check if the view is ready to recieve a product or not (view needs to be loaded first)
      if viewIfLoaded != nil { //PB ep68 13mins
         detailSummaryView.updateView(with: currentProduct) //PB ep68 14mins pass our currentProduct //now we can call this method in our computed product
      }
      
      
   }
   
   
}
