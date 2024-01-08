//
//  DealerSearchVM.swift
//  Luban
//
//  Created by King on 8/16/20.
//

import UIKit

class DealerSearchVM: NSObject {
    var arrDealerModel = [DealerDetailModel]()
    var currentPage = 1
    var pageCount = Int()
    var searchKeyword = String()
       func getDealersList(completion:@escaping() -> Void){
        WebServices.shared.getDataRequest(urlString: "\(EndPoints.dealerSearch)?page=\(currentPage)", showIndicator: self.currentPage == 1 ? true : false) { (response) in
            if self.currentPage == 1 {
            self.arrDealerModel.removeAll()
            }
               if let dictData = response.data["data"] as? NSDictionary {
                if let pages = dictData["total_page"] as? Int{
                    self.pageCount = pages
                }
                if let arrNews = dictData["stores"] as? NSArray {
                   for dictNews in arrNews {
                       let objNewsModel = DealerDetailModel()
                       objNewsModel.getDealerDict(dictData: dictNews as! NSDictionary)
                       self.arrDealerModel.append(objNewsModel)
                   }
               }
            }
               completion()
           }
       }
    
    func searchDealers(completion:@escaping() -> Void){
        let param = ["zipcode":self.searchKeyword]
        WebServices.shared.postDataRequest(urlString: EndPoints.dealerStoreSearch, params: param, showIndicator: true) { (response) in
            if self.currentPage == 0 {
            self.arrDealerModel.removeAll()
            }
            if let dictData = response.data["data"] as? NSDictionary {
             if let arrNews = dictData["stores"] as? NSArray {
                for dictNews in arrNews {
                    let objNewsModel = DealerDetailModel()
                    objNewsModel.getDealerDict(dictData: dictNews as! NSDictionary)
                    self.arrDealerModel.append(objNewsModel)
                }
            }
         }
            completion()
        }
    }

}
extension DealerSearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objDealersVM.arrDealerModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealerSearchTVC", for: indexPath) as! DealerSearchTVC
        let dictDealer = objDealersVM.arrDealerModel[indexPath.row]
        cell.lbl_nam.text = dictDealer.company
        cell.lbl_Address.text = "\(dictDealer.addressOne) \(dictDealer.addressTwo)"
        cell.lbl_phone.text = dictDealer.userPhone
        cell.viewBtn.tag = indexPath.row
        cell.viewBtn.addTarget(self, action: #selector(gotoDealerDet(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == objDealersVM.arrDealerModel.count - 1 {
            if objDealersVM.currentPage + 1 <= objDealersVM.pageCount {
                objDealersVM.currentPage = objDealersVM.currentPage + 1
                objDealersVM.getDealersList {
                    self.listTableView.reloadData()
                }
            }
        }
    }
    
    @objc func gotoDealerDet(_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DealerDetailVC") as! DealerDetailVC
        let dictDealer = objDealersVM.arrDealerModel[sender.tag].id
        vc.dealerID = dictDealer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension DealerSearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            objDealersVM.getDealersList {
                self.listTableView.reloadData()
            }
        } else {
            objDealersVM.searchKeyword = searchBar.text!
            objDealersVM.searchDealers {
                self.listTableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            objDealersVM.getDealersList {
                self.listTableView.reloadData()
            }
            searchBar.resignFirstResponder()
        }
    }
}
