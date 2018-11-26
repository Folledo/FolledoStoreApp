//
//  MyButton.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/25/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit //PB ep67 0mins


@IBDesignable  //PB ep67 1mins declaring this will allow us to use this button in designing in storyboard
class MyButton: UIButton { //PB ep67 1mins subclass of UIButton this will be the class of quantity button and add to cart button
   
//properties we will use for the button
   @IBInspectable var cornerRadius: CGFloat = 0.0 //PB ep67 1mins to design in storyboard, assign the property as @IBInspectable, which has a default value of 0
   @IBInspectable var borderWidth: CGFloat = 0.0 //PB ep67 1mins
   @IBInspectable var borderColor: UIColor = UIColor.clear //PB ep67 2mins clear borderwidth
   
   override func draw(_ rect: CGRect) { //PB ep67 2mins since we extended the UIButton, we need this override the draw function
      self.layer.cornerRadius = cornerRadius //PB ep67 2mins in this method, we will assign our button
      self.layer.borderWidth = borderWidth //PB ep67 2mins
      self.layer.borderColor = borderColor.cgColor //PB ep67 3mins
   }
   
   
   
}
