//
//  FavouriteVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 28/03/20.
//

import UIKit

class FavouriteVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var lbl_noData: UILabel!
    @IBOutlet weak var favouriteCV: UICollectionView!{
        didSet{
            favouriteCV.delegate = self
            favouriteCV.dataSource = self
        }
    }
    
    fileprivate var wishlistServiceManager = WishlistServiceManager()
    var wishlistItemsDataModel = [CartItemsDataModel]()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouriteCV.isHidden = true
        self.lbl_noData.isHidden = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        favouriteCV.collectionViewLayout =  layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gettingWishlistItems()
    }
    
    func gettingWishlistItems(){
        wishlistServiceManager.getWishlistItems { (wishlistResponse, error) in
            if error != nil{
                
            }else{
                if wishlistResponse?.wishlistItemsDataModel.count != 0{
                    self.wishlistItemsDataModel = wishlistResponse?.wishlistItemsDataModel ?? []
                    self.favouriteCV.reloadData()
                    self.lbl_noData.isHidden = true
                    self.favouriteCV.isHidden = false
                }else{
                    self.lbl_noData.isHidden = false
                    self.favouriteCV.isHidden = true
                }
                
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func menuTapped(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
//        self.sideMenuController?.toggleLeftViewAnimated()
    }
    
    
}
extension FavouriteVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistItemsDataModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishlistCVC", for: indexPath) as! WishlistCVC
        cell.gettingUpdateUI(self.wishlistItemsDataModel[indexPath.item])
        cell.delegate = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.favouriteCV.frame.width / 2
        return CGSize(width: width - 10, height: 300)
        //return CGSize(width: 175, height: 250)
        
    }
}
extension FavouriteVC:WishlistCVCDelegate{
    func removeFromWishlist(_ rowId: String) {
        wishlistServiceManager.removeFromwishlist(rowId) { (response, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            }else{
                Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                self.viewWillAppear(true)
            }
        }
    }
    func moveToCart(_ rowID: String) {
        wishlistServiceManager.moveItemToCart(rowID) { (response, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            }else{
                Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                self.viewWillAppear(true)
            }
        }
    }
}
