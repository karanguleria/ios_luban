//
//  MyOrderServiceManager.swift
//  Luban
//
//  Created by MAC on 30/08/20.
//

import Foundation
import SwiftyJSON

class MyOrderServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getMyOrders(completionHandler:@escaping(_ response:MyorderDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.my_orders
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let orderData = MyorderDataModel().parseMyOrderData(JSON(response.data["data"] as Any))
                
                    completionHandler(orderData,nil)
                } else {
                 completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func getMySingleOrders(_ id:Int,completionHandler:@escaping(_ response:MyorderDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.my_orders + "/\(id)"
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let orderData = MyorderDataModel().parseMyOrderData(JSON(response.data["data"] as Any))
                    completionHandler(orderData,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
}
