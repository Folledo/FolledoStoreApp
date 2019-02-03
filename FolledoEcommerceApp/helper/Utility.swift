//
//  Utility.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class Utility { //PB ep9 20mins
   
   
   class func image(withName name: String?, andType type: String) -> UIImage? { //PB ep9 21mins this method creates annd returns an image from an imageName
      let imagePath = Bundle.main.path(forResource: name?.stripFileExtension(), ofType: type) //PB ep9 22mins //25mins strip off the image type extension like .jpg and .png
      
      var image: UIImage? //PB ep9 25mins
      if let path = imagePath { //PB ep9 25mins now tat we have imagePath we can create the UIImage
         image = UIImage(contentsOfFile: path) //PB ep9 25mins
      }
      return image //PB ep9 26mins
   }
   
   
   class func currentYear() -> Int { //PB ep92 32mins will get the current year
      let calendar = Calendar.current //PB ep91 33mins
      let currentYear: Int = calendar.component(Calendar.Component.year, from: Date()) //PB ep91 33mins get the current year from today's date
      return currentYear
   }
   
   class func currentMonth() -> Int { //PB ep91
      let calendar = Calendar.current
      let currentMonth: Int = calendar.component(Calendar.Component.month, from: Date())
      return currentMonth
   }
}
