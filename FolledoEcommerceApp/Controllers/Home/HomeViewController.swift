//
//  HomeViewController.swift
//  FolledoEcommerceApp
//
//  Created by Samuel Folledo on 11/18/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController { //PB ep.5
   
   
//MARK: IBOutlet
   @IBOutlet weak var pageView: UIView! //PB ep5 8mins
   
   @IBOutlet weak var pageControl: UIPageControl! //PB ep7 2mins lets manipulate this in loadNextController
   
   @IBOutlet weak var topsCollectionView: UICollectionView!
   
   @IBOutlet weak var pantsCollectionView: UICollectionView!
   
   
   
//MARK: Properties
   var pageViewController: UIPageViewController? //PB ep5 10mins
   var pageImageArray = ["topBanner1", "topBanner2", "topBanner3", "topBanner4"] //PB ep5 15mins
   var currentIndex = 0 //PB ep6 1mins
   var topsCollection = [Product]() //PB ep11 10mins will contain our products we load
   var pantsCollection = [Product]() //PB ep11 10mins
   
//MARK: LifeCycle
   override func viewDidLoad() { //PB ep.5
      super.viewDidLoad()
      
      Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(HomeViewController.loadNextController), userInfo: nil, repeats: true) //PB ep6 4mins call loadNextController every 3 seconds
      
      setPageViewController() //PB ep5 32mins
      loadProducts() //PB ep11
   }
    
   
//MARK: Private Functions
   private func setPageViewController() { //PB ep5 11mins //Dont forget to make our pageView clipped to bounds, and PageViewController's transition style to scroll
      let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController //PB ep5 12mins get our vc
      pageVC.dataSource = self //PB ep5 12mins we need to tell this pagevc that we are going to assign the dataSource for this pagevc and assign it to the homeVC which is self //PB ep5 22mins make sure you implement our PageViewController DataSource to our HomeVC
      
      let firstController = getViewController(atIndex: 0) //PB ep5 18mins put the index of the initialVC as 0
      
      pageVC.setViewControllers([firstController], direction: .forward, animated: true, completion: nil) //PB ep5 19mins
      self.pageViewController = pageVC //PB ep5 19mins//assign this vc to our VC Property
      
      self.addChild(self.pageViewController!) //PB ep5 20mins add the pageViewController as the childVC of our HomeVC, unwrap it because we're sure it should be nil
   //now we want it to only occupy our pageView, not the whole controller
      self.pageView.addSubview(self.pageViewController!.view) //PB ep5 21mins add pageVC to our pageView outlet
      self.pageViewController?.didMove(toParent: self) //PB ep5 22mins //didMove = Called after the view controller is added or removed from a container view controller.
      
   }
   
   fileprivate func getViewController(atIndex index: Int) -> PromoContentViewController { //PB ep5 13mins return our VC //PB ep5 27mins private func changed to fileprivate func so we can access this method in our extension inside this swift file. Private will only allow us to do so inside the class brackets
      let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentViewController //PB ep5 14mins get our vc
      promoContentVC.imageName = pageImageArray[index] //PB ep5 18mins pass our image name to the vc
      promoContentVC.pageIndex = index //PB ep5 18mins pass our index
      return promoContentVC //PB ep5 18mins
   }
   
   
   @objc private func loadNextController() { //PB ep6 0mins automatically load the next VC
      currentIndex += 1 //PB ep6 1mins
      if currentIndex == pageImageArray.count { //PB ep6 1mins
         currentIndex = 0 //PB ep6 2mins if we reach the last image, then go back to 0
      }
      let nextController = getViewController(atIndex: currentIndex) //PB ep6 2mins
      self.pageViewController?.setViewControllers([nextController], direction: .forward, animated: true, completion: nil) //PB ep6 3mins
      
      self.pageControl.currentPage = currentIndex
   }
   
   func loadProducts() { //PB ep11 1mins
      topsCollection = ProductService.productsCategory(category: "top") //PB ep11 11mins since w ecreate it as static, we dont need an instance for ProductService //category will be "top"
      pantsCollection = ProductService.productsCategory(category: "pants") //PB ep11 11mins
      
      
   }
   
}


//MARK: UIPageViewController DataSource
extension HomeViewController: UIPageViewControllerDataSource { //PB ep5 22mins
//before
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { //PB ep5 23mins create the contentVC for the before page
      let pageContentVC = viewController as! PromoContentViewController //PB ep5 24mins
      var index = pageContentVC.pageIndex //PB ep5 25mins get the index from this VC so we can keep track of it
      
      if index == 0 || index == NSNotFound { //PB ep5 27mins if it is 0 or not found...
         return getViewController(atIndex: pageImageArray.count - 1) //PB ep5 28mins start it and give it a value of our array - 1
         // 0 | 1 | 2 | 0 | 1 | 2 | ....
      }
      
      index -= 1 //PB ep5 28mins index = index - 1
      return getViewController(atIndex: index) //PB ep5 29mins
   }
   
//after
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { //PB ep5 29mins
      let pageContentVC = viewController as! PromoContentViewController //PB ep5 30mins
      var index = pageContentVC.pageIndex //PB ep5 30mins
      
      if index == NSNotFound { //PB ep5 30mins
         return nil //PB ep5 31mins
      }
      
      index += 1 //PB ep5 31mins increment by 1 because this is after
      if index == pageImageArray.count { //PB ep5 31mins if index is equal to our images array, then we go back to 0 index
         return getViewController(atIndex: 0) //PB ep5 31mins
      }
      return getViewController(atIndex: index)
   }
}

//MARK: UICollectionViewDataSource //PB ep11 12mins
extension HomeViewController: UICollectionViewDataSource { //PB ep11 12mins remember we have 2 different collectionView, we need to differentiate which collectionView we're working on. //our methods required for DataSource
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { //PB ep11 12mins
      switch collectionView { //PB ep11 13mins switch between our collectionView
         
   //tops
      case self.topsCollectionView: //PB ep11 13mins
         return self.topsCollection.count //PB ep11 13mins
         
   //pants
      case self.pantsCollectionView:
         return self.pantsCollection.count //PB ep11 13mins
         
      default: //PB ep11 13mins
         return 0 //PB ep11 13mins dont display anything
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { //PB ep11 12mins
      
      switch collectionView { //PB ep11  //PB ep11 14mins we also need to know which collectionView we're working on in this VC
   //tops
      case self.topsCollectionView: //PB ep11 14mins because we the custom collection view cell, we need to subclass the collectionViewCell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTops", for: indexPath) as! ProductCollectionViewCell //PB ep11 20mins create the cell with the identifier as! our cell.swift
         let product = topsCollection[indexPath.row] //PB ep11 21mins get the particular product we want to display in our cell
         cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "png") //PB ep11 22mins this collectionViewCell will only display 1 image from the mainImage from the Product entity
         return cell //PB ep11 23mins
         
   //pants
      case self.pantsCollectionView: //PB ep11 14mins
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPants", for: indexPath) as! ProductCollectionViewCell //PB ep11
         let product = pantsCollection[indexPath.row] //PB ep11 23mins
         cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "png") //PB ep11 23mins
         return cell
         
      default: //PB ep11 14mins
         return UICollectionViewCell() //PB ep11 23mins if nothing then return an instance of cell
      }
      
   }
   //PB ep11 12mins
   
   
}
