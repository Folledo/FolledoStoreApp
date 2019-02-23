//
//  ProductDetailViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/26/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate { //PB ep68 0mins
   
   
//MARK: IBOutlet
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var detailSummaryView: DetailSummaryView! //PB ep68 2mins contentView
   @IBOutlet weak var productDescriptionImageView: UIImageView!
   @IBOutlet weak var productDescriptionLabel: UILabel!
   @IBOutlet weak var tableView: UITableView!
   
   @IBOutlet weak var shoppingCartButton: UIBarButtonItem! //PB ep76 9mins //PB ep80 3mins
//   @IBOutlet weak var cartItemCountLabel: UILabel! //PB ep76 9mins
   
   
//MARK: Properties
   var product: Product? { //PB ep68 11mins so we're going to initiate the update of the detail summary view whenever a product has been set. In order to do that, we need a computed property with didSet
      didSet { //PB ep68 11mins
         if let currentProduct = product { //PB ep68 12mins check if product is nil or not. If product is not nil, then we pass in that product to the detailSummaryView
            self.showDetail(for: currentProduct) //PB ep68 14mins //PB ep72 2mins specification was added in showDetail
         }
      }
   }
   
   
   var specifications = [ProductInfo]() //PB ep72 1mins ProductInfo entity. //showDetail(for:)
   var quantity = 1 //PB ep74 8mins will store the TVC's quantity passed down from the delegate method. First time will be 1
   var shoppingCart = ShoppingCart.sharedInstance //PB ep76 12mins this guarantee that the shoppingCart property will have the singleton of the ShoppingCart class
   
//shopping cart button with custom view
   let cartButton = UIButton(frame: CGRect(x: 10, y: 10, width: 35, height: 30)) //PB ep80 4mins
   let cartLabel = UILabel(frame: CGRect(x: 22, y: 2, width: 16, height: 16)) //PB ep80 5mins
   let cartView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) //PB ep80 5mins
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.scrollView.delegate = self
      setCartView() //PB ep80 13mins
   }
	
	override func viewWillAppear(_ animated: Bool) { //PB ep96 18mins
		super.viewWillAppear(animated) //PB ep96 18mins
		
		self.cartLabel.text = "\(self.shoppingCart.totalItem())" //PB ep96 19mins to update it after order confirmation because it doesnt update it
	}
   
   
//MARK: Private
   private func setCartView() { //PB ep80 6mins
      cartButton.setBackgroundImage(UIImage(named: "shopping_cart"), for: .normal) //PB ep80 7mins
       //PB ep80 set a target, so there is an action associated on pressed
      cartButton.addTarget(self, action: #selector(ProductDetailViewController.viewCart(sender:)), for: .touchUpInside) //PB ep80 8mins add the method whenever it is touchUpInside
      cartLabel.text = "0" //PB ep80 9mins
      cartLabel.textColor = UIColor(red: 0.808, green: 0.490, blue: 0.273, alpha: 2.0) //PB ep80 9mins
      cartLabel.textAlignment = .center //PB ep80 10mins
      cartLabel.font = UIFont(name: "System", size: 14.0) //PB ep80 10mins
      cartLabel.numberOfLines = 1 //PB ep80 11mins
      cartLabel.adjustsFontSizeToFitWidth = true //PB ep80 11mins allows udjustment to font
      
      cartView.addSubview(cartButton) //PB ep80 11mins
      cartView.addSubview(cartLabel) //PB ep80 11mins
      
      shoppingCartButton.customView = cartView //PB ep80 12mins
   }
   @objc func viewCart(sender: UIButton) { //PB ep80 7mins perform segue whenever the cartButton is tapped
      performSegue(withIdentifier: "toCartSegue", sender: self) //PB ep80 7mins
   }
   
   private func showDetail(for currentProduct: Product) { //PB ep68 12mins before we load the product into the detailSummaryView, we check if the view is ready to recieve a product or not (view needs to be loaded first)
      if viewIfLoaded != nil { //PB ep68 13mins
         detailSummaryView.updateView(with: currentProduct) //PB ep68 14mins pass our currentProduct //now we can call this method in our computed product
         
         let productInfo = currentProduct.productInfo?.allObjects as! [ProductInfo] //PB ep72 2mins when the currentProduct is being passed from the didSet computed property we have at top, we will be able to capture the productInfo for this currentProuct as we also have a relationship of productInfo in our xcodeDataModel //PB ep72 3mins productInfo NSSet can be convert it to an array by calling .allObjects, as! an array of ProductInfo
         self.specifications = productInfo.filter({ $0.type == "specs" }) //PB ep72 productInfo may have several type. In AppDelegate. We set the type to "specs" so for this specification we only want to filer the pipe that has a value of specs. //PB ep72 5-7mins to get the specification from productInfo, we need to filter for this productInfo array //$0 represent an object in the array, this filter loop through every object in productInfo, and each object is represented by $0 and it will be filtered by type = "specs". So if it has a type = "specs" then it will add it to the specification. Specification array now guarantee to only ave the productInfo with a type of "specs"
         
      //description
         var description = ""//PB ep72 7mins capture description
         for currentInfo in productInfo { //PB ep72 8mins
            if let info = currentInfo.info, info.count > 0, currentInfo.type == "description" { //PB ep72 8-9mins currentInfo,info comes from CoreDatamodel //Once we got info we want to make a quick check
                //PB ep72 9mins if condition is fulfilled, then we'll set description = description + info
               description = description + info + "\n\n" //PB ep72 9mins
            }
         }
         
         productDescriptionLabel.text = description //PB ep72 10mins
         productDescriptionImageView.image = Utility.image(withName: currentProduct.mainImage, andType: "png") //PB ep72 10mins
         
         tableView.reloadData() //PB ep72 11mins refresh
      }
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) { //disable horizontal scrolling
      if scrollView.contentOffset.x != 0 {
         scrollView.contentOffset.x = 0
      }
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //PB ep74 4mins
      if let identifier = segue.identifier { //PB ep74 4mins switch between segue
         switch identifier { //PB ep74 4mins
         case "toQuantitySegue": //PB ep74 5mins
            let quantityTVC = segue.destination as! QuantityTableViewController //PB ep74 6mins
            quantityTVC.delegate = self //PB ep74 7-8 now that we have the TVC, we can now access the delegate and set it to self. Important to implement the delegate method as an extension
            
         case "toCartSegue": //PB ep81 18mins if invoked, get its destination first
            let navController = segue.destination as! UINavigationController //PB ep81 18mins
            let cartTVC = navController.topViewController as! CartTableViewController //PB ep81 19mins, now we got ref to our TVC
            cartTVC.cartDelegate = self //PB ep81 19mins cartTVC's cartDelegate which has a type of ShoppingCartDelegate, now we need to implement the methods that belong to cartdelegeate
         default: //PB ep74 4mins
            break
            
         }
      }
   }
   
   
   
//MARK: IBActions
   @IBAction func addToCartButtonTapped(_ sender: MyButton) { //PB ep76 10mins this method adds the currently selected/displayed product to our cart. We can get the product from product property
      if let product = product { //PB ep76 11mins we can get that product from our property
         shoppingCart.add(product: product, quantity: self.quantity) //PB ep76 12mins before we can invoke our add function, we need to get the instance of ShoppingCart //add the product and our quantity
         
      //Reset the quantity
         self.quantity = 1 //PB ep76 13mins
         self.detailSummaryView.quantityButton.setTitle("Quantity: 1", for: .normal) //PB ep76 14mins
         
      //PB ep76 14mins //Update our quantityLabel on top of our cartButton with some animation
         UIView.animate(withDuration: 0.5) { [weak self] in //PB ep76 15mins animate withDuration //PB ep76 17mins weak self in allows us make a reference to the property inside this controller class
            self?.cartButton.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0.0, 1.0, 0) //PB ep76 17-18mins rotate 180 degrees against the y axis
         } //PB ep76 18mins first half of the animation
         
         UIView.animate(withDuration: 0.5, animations: { [weak self] in  //PB ep76 19mins
            self?.cartButton.layer.transform = CATransform3DMakeRotation(CGFloat.pi * 2, 0.0, 1.0, 0.0) //PB ep76 20mins finish the whole rotation from 180-360 degrees on the y axis
         }, completion: { (success) in //PB ep76 20mins now on a different thread, but when we update our UI, we need to get to our main thread in order to update our UI, by calling DispatchQueue
            DispatchQueue.main.async { [unowned self] in //PB ep76 21mins go back to the main thread and update our label. //PB ep76 23mins [weak self] in is changed to [unowned self] in, which basically says "I am not going to create a strong reference to this VC, but at the same time, I guarantee that self is not going to be nil". This allows us to not have an optional text in our string
               self.cartLabel.text = "\(String(describing: self.shoppingCart.totalItem()))" //PB ep76 22mins
            }
         })
         
      }
   }
   
   
} //end of class


//MARK: UITableView DataSource
extension ProductDetailViewController: UITableViewDataSource { //PB ep72 11mins
   func numberOfSections(in tableView: UITableView) -> Int { //PB ep72 12mins
      return 1 //PB ep72 12mins
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //PB ep72 12mins
      return self.specifications.count //PB ep82 12mins
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //PB ep72 13mins
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "productInfoCell", for: indexPath) as! ProductInfoTableViewCell //PB ep72 13mins create a cell from storyboard
      cell.productInfo = self.specifications[indexPath.row] //PB ep72 17mins
      return cell //PB ep72 18mins
   }
   //PB ep72 11mins
}


//MARK: QuantityPopover Delegate
extension ProductDetailViewController: QuantityPopoverDelegate { //PB ep74 8mins implementation of the delegate, dont forget to assign quantityTVC.delegate to self in prepare for segue
   
   func updateProductToBuy(withQuantity quantity: Int) { //PB ep74 8mins now we call this method, where we buy the quantity that is selected. To capture the quantity, we need a property we can store this value from the TVC
      self.quantity = quantity //PB ep74 9mins update our quantity the was passed
      detailSummaryView.quantityButton.setTitle("Quantity: \(self.quantity)", for: .normal) //PB ep74 9mins now we can update the text in our buttons, which lives in detailSummaryView //10mins now the calling controller which is ProductDetailVC, will be able to update the quantity and the buttons, but now we need to communicate back this quantity from the QuantityTVC, using didSelectRowAt
   }
}

extension ProductDetailViewController: UIPopoverPresentationControllerDelegate {
   
   func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool { //called whenever user taps outside the popover controller
      return true
   }
}


//MARK: ShoppingCartDelegate
extension ProductDetailViewController: ShoppingCartDelegate { //PB ep81 20mins
   func updateTotalCartItem() { //PB ep81 20mins
      cartLabel.text = "\(shoppingCart.totalItem())" //PB ep81 21mins this will allow us to update to update the button as the quantity change in the viewCartScene
   }
}
