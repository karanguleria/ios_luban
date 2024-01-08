//
//  HomeVM.swift
//  Luban
//
//  Created by King on 11/23/20.
//

import UIKit

class HomeVM: NSObject {

}
extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchbar.text!.isEmpty {
           return
        } else {
            let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
            searchVC.objSearchVM.searchKeyword = searchbar.text!
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        searchbar.resignFirstResponder()
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchbar.resignFirstResponder()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView{
            return HomeCategoryModel.sliderDataModel.count
        } else {
            return HomeCategoryModel.categoryDataModel.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView{
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCVC", for: indexPath) as! HomeBannerCVC
            bannerCell.bannerImg.sd_setImage(with: URL(string: HomeCategoryModel.sliderDataModel[indexPath.item].img!), placeholderImage: UIImage(named: "door"))
            bannerCell.lbl_name.text = HomeCategoryModel.sliderDataModel[indexPath.item].title
            return bannerCell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCVC", for: indexPath) as! HomeCategoryCVC
            let dictCat = HomeCategoryModel.categoryDataModel[indexPath.item]
            cell.lbl_name.text = indexPath.item == 6 ? "" : dictCat.title
            cell.imgView.sd_setImage(with: URL(string: dictCat.img!), placeholderImage: UIImage(named: "door"))
            
            cell.alphaView.isHidden = indexPath.item == 6
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView{
           return CGSize(width: self.bannerCollectionView.frame.width, height: self.bannerCollectionView.frame.height)
        } else {
        if indexPath.item == 6 {
            let width = self.clcViewForCategories.frame.width / 2
            return CGSize(width: self.clcViewForCategories.frame.width, height: width - 4)
        } else {
            let width = self.clcViewForCategories.frame.width / 2
            return CGSize(width: width - 8, height: width - 4)
        }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            
        }else{
            guard let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as? ProductListVC else{
                return
            }
            productVC.slug = HomeCategoryModel.categoryDataModel[indexPath.row].slug ?? ""
            self.navigationController?.pushViewController(productVC, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            self.pageControl.currentPage = indexPath.item
        }else{
            
        }
        
    }
    
}
