//
//  OrderHistoryVC.swift
//  Luban
//
//  Created by King on 6/1/20.
//

import UIKit

class OrderHistoryVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tblViewOrders: UITableView!
    fileprivate var myOrderServiceManager = MyOrderServiceManager()
    var orderListDataModel = [OrderListDataModel]()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyOrder()
    }
    
    func getMyOrder(){
        myOrderServiceManager.getMyOrders { (myOrderResponse, error) in
            if error != nil{
                
            }else{
                self.orderListDataModel = myOrderResponse?.orderListDataModel ?? []
                self.tblViewOrders.reloadData()
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func actionMenu(_ sender: UIButton) {
        KAppDelegate.sideMenuVC.openLeft()
    
    }
    
    @IBAction func actionMyCart(_ sender: UIButton) {
        push(identifier: "MyCartVC")
    }
}

extension OrderHistoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTVC") as! MyCartTVC
        let dataItem = self.orderListDataModel[indexPath.row]
        cell.lbl_orderNo.text = "Order number : \(dataItem.id ?? 0)"
        cell.lbl_totalPrice.text = "Total Price : \(dataItem.billing_total ?? "0")"
        cell.lbl_orderOn.text = "Order On: \(dataItem.date ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailVC") as? OrderDetailVC else {
            return
        }
        detailVC.id = self.orderListDataModel[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
