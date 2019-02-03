//
//  PaymentViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 1/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController { //PB ep89 30mins
   
   @IBOutlet var mainView: UIView!
   
   
//MARK: Properties
   var customer: Customer? //PB ep90 23mins
   
   
   
   override func viewDidLoad() { //PB ep89 30mins
      super.viewDidLoad()

      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      self.mainView.addGestureRecognizer(tap)
   }
   
   
   @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      self.view.endEditing(true)
   }
   
   
   
   
}
