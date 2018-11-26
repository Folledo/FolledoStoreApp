//
//  PromoContentViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/18/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class PromoContentViewController: UIViewController { //PB ep5
   
//MARK: Properties
   var pageIndex = 0 //PB ep5 16mins
   var imageName: String? //PB ep5 16mins
   
   
//MARK: IBOutlet
   @IBOutlet weak var promoImageView: UIImageView! //PB ep.5 8mins
   
   
//MARK: LifeCycle
   override func viewDidLoad() { //PB ep.5 
      super.viewDidLoad()
      
      if let currentImage = imageName { //PB ep5 17mins, if our imageName has a value, then we set it to our imageView
         promoImageView.image = UIImage(named: currentImage)
      }
      
   }
    
   
   
}
