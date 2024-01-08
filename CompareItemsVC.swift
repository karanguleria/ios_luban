//
//  CompareItemsVC.swift
//  Luban
//
//  Created by King on 11/18/20.
//

import UIKit
import SwiftyJSON

class CompareItemsVC: UIViewController {
    //MARK:- Outlets and Variables
    @IBOutlet weak var tblViewItems: UITableView!
    var arrCompareItems = [SubCategoryDataModel]()
    var productDetail = ProductsModel()
    var arrCompareResult = [CompareModel]()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        compareItems()
    }
   
    //MARK:- Actions
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
    
    func compareItems(){
        if arrCompareItems.count != 0 {
            self.compareProducts(self.arrCompareItems) {(response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.arrCompareResult = response?.arrComare ?? []
                        self.tblViewItems.reloadData()
                    }
                    
                }
            }
        }
    }
}

extension CompareItemsVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrCompareResult.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCompareResult[section].arrDiscriptionKeys.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompareProductsTVC") as! CompareProductsTVC
        let subCat = self.arrCompareResult[section]
        cell.lblProductName.text = subCat.name
        cell.lblDescription.text = ""
        cell.delegate = self
        if subCat.image != nil {
        cell.imgViewProduct.sd_setImage(with: URL(string: subCat.image!), placeholderImage: UIImage(named: "door"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompareProductDescTVC") as! CompareProductDescTVC
        let subCat = self.arrCompareResult[indexPath.section].arrDiscriptionKeys[indexPath.row]
        cell.lblTitle.text = subCat.key
        cell.lblDescription.text = subCat.val
        return cell
    }
    
    func compareProducts(_ products:[SubCategoryDataModel],completionHandler:@escaping(_ response:ProductsModel?,_ error:String?)->()){
        var requestUrl = String()
        if products.count == 4 {
            requestUrl = EndPoints.compare + "\(products[0].id),\(products[1].id),\(products[2].id),\(products[3].id)?device_id=" + DeviceInfo.deviceUDID
        } else if products.count == 3 {
            requestUrl = EndPoints.compare + "\(products[0].id),\(products[1].id),\(products[2].id)?device_id=" + DeviceInfo.deviceUDID
        } else if products.count == 2 {
            requestUrl = EndPoints.compare + "\(products[0].id),\(products[1].id)?device_id=" + DeviceInfo.deviceUDID
        } else {
            requestUrl = EndPoints.compare + "\(products[0].id)?device_id=" + DeviceInfo.deviceUDID
        }
        WebServices.shared.postDataRequest(urlString: requestUrl, params: ["":""], showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let compare = ProductsModel().getNewsDict(JSON(response.data["data"]!))
                    completionHandler(compare,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
}
extension CompareItemsVC:CompareProductsTVCDelegate{
    func viewProduct(sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC else{
            return
        }
        vc.productId = self.arrCompareResult[sender.tag].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
