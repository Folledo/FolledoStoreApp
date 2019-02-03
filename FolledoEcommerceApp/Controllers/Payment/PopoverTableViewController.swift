//
//  PopoverTableViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 2/3/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

enum PopInfoType: String { //PB ep92 5mins
   case expMonth = "Expiration Month" //PB ep92 5mins
   case expYear = "Expiration Year" //PB ep92 5mins
}

protocol PopInfoSelectionDelegate: class { //PB ep92 14mins
   func updateWithPopInfoSelection(value: String, sender: UIButton) //PB ep92 15mins we need sender as UIButton so we can know which button opened the popover. The title of the sender will be updated based on the value that being selected
}

class PopoverTableViewController: UITableViewController { //PB ep92 4mins
   
//MARK: Properties
   var popInfoType: PopInfoType? //PB ep92 6mins this will store the popOverInfo type enum
   var data = [String]() //PB ep92 6mins since we have a dynamic cell, we wil create this data soure
   var sender: UIButton? //PB ep92 16mins
   weak var delegate: PopInfoSelectionDelegate? //PB ep92 16mins
   
   
   override func viewDidLoad() { //PB ep92 4mins
      super.viewDidLoad()
      
      switch popInfoType! { //PB ep92 7mins
      case .expMonth: //PB ep92 7mins
         data = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"] //PB ep92 8mins
      case .expYear: //PB ep92 8mins
         let currentYear = Utility.currentYear() //PB ep92 9mins
         for year in currentYear...currentYear + 10 { //PB ep92 9mins we will start with the current year, we will add 10 more years after
            data.append(String(year)) //PB ep92 10mins
         }
      }
   }
   
   
// MARK: - Table view data source
   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      return 1 //PB ep92 11mins
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return data.count //PB ep92 11mins
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep92 11mins
      tableView.rowHeight = 40 //PB ep92 12mins
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "expireCell", for: indexPath) //PB ep92 12mins
      cell.textLabel?.text = data[indexPath.row] //PB ep92 12mins
      return cell //PB ep92 12mins
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //PB ep92 12mins we will need to communicate the selected month or year, back to the PaymentVC and update the buttons based on the selected month or year number
      delegate!.updateWithPopInfoSelection(value: data[indexPath.row], sender: self.sender!) //PB ep92 17mins once a selection has been made by the user, we call the delegate method
      dismiss(animated: true, completion: nil) //PB ep92 17mins after selection is made, we can now dismiss it
   }
      
}
