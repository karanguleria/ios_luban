//
//  SearchProductVC.swift
//  Luban
//
//  Created by King on 11/28/20.
//

import UIKit

class SearchProductVC: UIViewController, UIPopoverPresentationControllerDelegate{
    
    //MARK:- Outlets
    @IBOutlet weak var tblViewSearch: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblYourPrice: UILabel!
    
    var objSearchVM = SearchProductVM()
    var productDetailServiceManager = ProductDetailServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if Proxy.shared.accessTokenNil() != "" {
            lblYourPrice.isHidden = false
        } else {
            lblYourPrice.isHidden = true
        }
        searchBar.text = objSearchVM.searchKeyword
        objSearchVM.getProductFromSlug { (products, error) in
            self.tblViewSearch.reloadData()
        }
    }
    
    //MARK:- Actions
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
}
