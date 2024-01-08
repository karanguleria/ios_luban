//
//  SearchProductVM.swift
//  Luban
//
//  Created by King on 11/28/20.
//

import UIKit
import SwiftyJSON

class SearchProductVM: NSObject {
    var searchKeyword = String()
    var currentPage = 1
    var pageCount = Int()
    
    var productsDataModel = ProductDetailDataModel()
    func getProductFromSlug(completionHandler:@escaping(_ response:ProductDetailDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.searchProduct + "\(searchKeyword)&page=\(self.currentPage)"
        WebServices.shared.getDataRequest(urlString: requestUrl, showIndicator: self.currentPage == 1 ? true : false) { (response) in
            DispatchQueue.main.async {
               if response.success{
                    let product = ProductDetailDataModel().parseDatafromJson(JSON(response.data["data"]!))
                self.currentPage = product.currentPage ?? 1
                self.pageCount = product.total_page ?? 0
                    self.productsDataModel = product
                    completionHandler(product,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
}

extension SearchProductVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductAddToCartTVC") as! ProductAddToCartTVC
        cell.delegate = self
        cell.cartbtn.tag = indexPath.row
        cell.detailBtn.tag = indexPath.row
        cell.wishlistBtn.tag = indexPath.row
        let product = productsDataModel[indexPath.row]
        cell.lbl_itemNo.text = product.name
        cell.lbl_descrition.text = product.description
        if Proxy.shared.accessTokenNil() != "" {
            cell.lbl_msrp.text = "$\(product.price ?? "0")"
            cell.lbl_msrp.isHidden = false
        } else {
            cell.lbl_msrp.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let arrNotifications = productsDataModel
        
        if indexPath.row == arrNotifications.count - 1 {
            debugPrint("current page: \(objSearchVM.currentPage) Total Page :\(objSearchVM.pageCount) Array count: \(arrNotifications.count) Index PAth: \(indexPath.row)")
            if objSearchVM.currentPage + 1 <= objSearchVM.pageCount {
              objSearchVM.currentPage = objSearchVM.currentPage + 1
                objSearchVM.getProductFromSlug { (products, error) in
                    self.tblViewSearch.reloadData()
                }
            }
        }
    }
}
extension SearchProductVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            return
        } else {
            objSearchVM.searchKeyword = searchBar.text!
            objSearchVM.getProductFromSlug { (products, error) in
                self.tblViewSearch.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchProductVC: ProductAddToCartTVCDelegate{
    func addToWishlist(_ sender: UIButton) {
        let productId = "\(productsDataModel[sender.tag].id ?? 0)"
        productDetailServiceManager.addProductToWishlist(product: productId) { (successMessage, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            } else {
                Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
         }
    }
    }
    
    
    func showDetails(_ sender: UIButton) {
                guard let popVC = storyboard?.instantiateViewController(withIdentifier: "ProductPopoverVC") as? ProductPopoverVC else { return }
        popVC.productsDataModel = productsDataModel[sender.tag]
                popVC.modalPresentationStyle = .popover
                let popOverVC = popVC.popoverPresentationController
                popOverVC?.delegate = self
                popOverVC?.sourceView = sender
                popOverVC?.permittedArrowDirections = .any
                popOverVC?.sourceRect = sender.bounds
                popVC.preferredContentSize = CGSize(width: 315, height: 400)
                self.present(popVC, animated: true)
    }
    
    func addtoCart(_ sender: UIButton) {
        let productId = "\(productsDataModel[sender.tag].id ?? 0)"
        productDetailServiceManager.addProductToCart(product: productId) { (successMessage, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            } else {
                Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
            }
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController,traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
