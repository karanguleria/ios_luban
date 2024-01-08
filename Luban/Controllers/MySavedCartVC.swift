//
//  MySavedCartVC.swift
//  Luban
//
//  Created by King on 1/30/22.
//

import UIKit

class MySavedCartVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tblViewOrders: UITableView!
    fileprivate var myOrderServiceManager = MyOrderServiceManager()
    var orderListDataModel = [OrderListDataModel]()
    var objSavedCartVM = MySavedCartVM()
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
        push(identifier: "SaveCartDetailVC")
    }
}
