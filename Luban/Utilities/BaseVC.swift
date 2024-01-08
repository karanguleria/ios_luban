//
//  BaseVC.swift
//  Luban
//
//  Created by MAC on 04/10/20.
//

import UIKit

class BaseVC: UIViewController {

    fileprivate var wishlistServiceManager = WishlistServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getcartCount()
    }
    
    func getcartCount(){
        wishlistServiceManager.getCartCount { (response, error) in
            if error != nil {
               
            } else {
                self.gettingCartNadWishlistBatchCountDetails(response?.count ?? 0)
            }
        }
    }
    public func gettingCartNadWishlistBatchCountDetails(_ cartValue:Int) {
    }

}
