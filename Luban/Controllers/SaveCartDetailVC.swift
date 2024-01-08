//
//  SaverCartDetailVC.swift
//  Luban
//
//  Created by King on 1/30/22.
//

import UIKit

class SaveCartDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //MARK:- Outlets
    @IBOutlet weak var tblProducts: UITableView!
    @IBOutlet weak var lbl_priceDetail: UILabel!
    @IBOutlet weak var lbl_subTotal: UILabel!
    @IBOutlet weak var lbl_orderOn: UILabel!//Order On :  05-17-2020
    @IBOutlet weak var lbl_orderNo: UILabel!//Order No :1
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var lbl_saleTax: UILabel!
    @IBOutlet weak var lbl_discount: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    fileprivate var myOrderServiceManager = MyOrderServiceManager()
    var id:Int?
    var orderListDataModel = OrderListDataModel()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let ID = id else {
            return
        }
        self.getOrderDetail(ID)
    }
    
    func getOrderDetail(_ id:Int){
        myOrderServiceManager.getMySingleOrders(id) { (singleOrder, error) in
            if error != nil{
                
            }else{
                guard let order = singleOrder?.singelOrder else{
                    return
                }
                self.orderListDataModel = order
                self.lbl_priceDetail.text = "Price Details (\(order.productsDataModel.count) Items)"
                self.lbl_orderOn.text = "Order On: \(order.date ?? "")"
                self.lbl_orderNo.text = "Order No: \(id)"
                self.lbl_subTotal.text = "\(order.billing_subtotal ?? "0")"
                self.lbl_discount.text = "\(order.billing_discount ?? "0")"
                self.lbl_saleTax.text = "\(order.billing_tax ?? "0")"
                self.lbl_totalPrice.text = "\(order.billing_total ?? "0")"
                self.lblDeliveryFee.text = "\(order.deliverCost ?? "0")"
                self.tblProducts.reloadData()
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func actionMenu(_ sender: UIButton) {
        pop()
    }
    

    @IBAction func actionCart(_ sender: UIButton) {
        push(identifier: "MyCartVC")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTVC") as! MyCartTVC
        return cell
    }
    
}
