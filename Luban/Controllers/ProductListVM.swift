//
//  ProductListVM.swift
//  Luban
//
//  Created by King on 11/23/20.
//

import UIKit

class ProductListVM: NSObject {
    
}

//MARK:- CollectionView Delegate Extension
extension ProductListVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subcategoryDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCVC", for: indexPath) as! ProductListCVC
        cell.delegate = self
        let subCat = self.subcategoryDataModel[indexPath.item]
        cell.lbl_name.text = subCat.title
        cell.compareBtn.tag = indexPath.item
        cell.imgViewSale.isHidden = subCat.sale == "false"
        cell.product_imageView.contentMode = .scaleAspectFit
        cell.product_imageView.sd_setImage(with: URL(string: subCat.image), placeholderImage: UIImage(named: "door"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.productCollectionView.frame.width / 2
        return CGSize(width: width - 10, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {     guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC else{
        return
    }
    vc.productId = self.subcategoryDataModel[indexPath.item].id
    self.navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension ProductListVC:ProductListCVCDelegate{
    func compareProduct(_ sender: UIButton) {
        viewForCompare.isHidden = false
        if self.compareItemArray.count < 4 {
            if self.compareItemArray.contains(where: {$0.slug == self.subcategoryDataModel[sender.tag].slug}){
                Proxy.shared.displayStatusCodeAlert("Already Added in compare list.", title: "Error")
            } else {
                self.compareItemArray.append(self.subcategoryDataModel[sender.tag])
            }
        } else {
            Proxy.shared.displayStatusCodeAlert("Compare Array Full", title: "Error")
        }
        lblCompareItemCount.text = self.compareItemArray.count == 1 ? "\(self.compareItemArray.count) Item" : "\(self.compareItemArray.count) Items"
    }
}

extension ProductListVC: SelectedFilter {
    func filterOption(option: String, type: String, filterDict: NSMutableDictionary) {    let option = filterDict.value(forKey: "sort") as? String ?? ""
        let filterOne = filterDict.value(forKey: "filter_1") as? String ?? ""
        let filterTwo = filterDict.value(forKey: "filter_2") as? String ?? ""
        let param = ["sort":option,"filter_1":filterOne, "filter_2":filterTwo] as [String:AnyObject]
        paramForCat = param
        getSubcategory(slug: slug!)
    }
}
extension ProductListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            return
        } else {
            let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
            searchVC.objSearchVM.searchKeyword = searchBar.text!
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
}
