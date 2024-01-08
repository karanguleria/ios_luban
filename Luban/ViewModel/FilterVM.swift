//
//  FilterVM.swift
//  Luban
//
//  Created by King on 10/17/20.
//

import UIKit

class FilterVM: NSObject {
    var filterType = String()
    var arrSort = [SortDataModel]()
    var arrFilter = [FilterDataModel]()
    let dictForFilter = NSMutableDictionary()
}

extension FilterVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if objFilterVM.filterType == "Sort"{
            return 1
        } else {
            return objFilterVM.arrFilter.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if objFilterVM.filterType == "Sort"{
            return objFilterVM.arrSort.count
        } else {
            return objFilterVM.arrFilter[section].filterVal.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterReusableView", for: indexPath) as! FilterReusableView
        if objFilterVM.filterType == "Sort"{
            cell.lblFilter.text = "Sort Options"
        } else {
            let dictFilter = objFilterVM.arrFilter[indexPath.section].name
            cell.lblFilter.text = dictFilter
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        if objFilterVM.filterType == "Sort" {
            label.text = objFilterVM.arrSort[indexPath.row].name
        } else if objFilterVM.filterType == "Filter" {
            let dictFilter = objFilterVM.arrFilter[indexPath.section].filterVal[indexPath.row]
            label.text = dictFilter.name
        }
        label.sizeToFit()
        let width = label.frame.width
        return CGSize(width: width+30, height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if objFilterVM.filterType == "Sort" {
            let sortValue = objFilterVM.arrSort[indexPath.row].val
            objFilterVM.dictForFilter.setValue(sortValue, forKey: "sort")
        } else {
            let dictFilter = objFilterVM.arrFilter[indexPath.section].filterVal[indexPath.row]
            objFilterVM.dictForFilter.setValue(dictFilter.val, forKey: "filter_\(indexPath.section+1)")
        }
       collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCVC", for: indexPath) as! FilterCVC
        if objFilterVM.filterType == "Sort" {
           cell.lblFilterVC.text = objFilterVM.arrSort[indexPath.row].name
            let selVal = objFilterVM.dictForFilter.value(forKey: "sort") as? String
            cell.lblFilterVC.textColor = selVal == objFilterVM.arrSort[indexPath.row].val ? .red : .black
        } else if  objFilterVM.filterType == "Filter" {
            let dictFilter = objFilterVM.arrFilter[indexPath.section].filterVal[indexPath.row]
                    let selVal = objFilterVM.dictForFilter.value(forKey: "filter_\(indexPath.section+1)") as? String
                    cell.lblFilterVC.textColor = selVal == dictFilter.val ? .red : .black
            cell.lblFilterVC.text = dictFilter.name
        }
        return cell
    }
}
