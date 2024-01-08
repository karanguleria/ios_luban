//
//  CartServiceManager.swift
//  Luban
//
//  Created by MAC on 30/08/20.
//

import Foundation
import SwiftyJSON

class CartServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getCart(completionHandler:@escaping(_ response:CartDataModel?,_ error:String?)->()){
        var requestUrl = String()
        
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.cart
        } else {
            requestUrl = EndPoints.cart + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let cartData = CartDataModel().parseCartData(JSON(response.data["data"] as Any))
                    
                    completionHandler(cartData,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func clearCartApi(completionHandler:@escaping(_ msg:String)->()){
        let url = EndPoints.clearCart + "?device_id=\(DeviceInfo.deviceUDID)"
        WebServices.shared.getDataRequest(urlString: url, showIndicator: true) { (response) in
            if response.success{
                completionHandler(response.message ?? "")
            } else {
                Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
            }
       }
    }
   
    func checkoutOrder(completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        let requestUrl = EndPoints.checkout + "?device_id=" + DeviceInfo.deviceUDID
        let userInfo = UserInfo.shared.member
        let param = ["email":userInfo.email,"name":userInfo.name,"address":"\(userInfo.address1 ?? "") \(userInfo.address2 ?? "")","city":userInfo.city,"state":userInfo.state,"zipcode":"1213344","phone":userInfo.phone]
        
        webServiceManager.postDataRequest(urlString: requestUrl, params: param as [String : Any], showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    //let cartData = CartDataModel().parseCartData(JSON(response.data["data"] as Any))
                
                    completionHandler(response.message,nil)
                } else {
                 completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func deleteCartRequest(id:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
        requestUrl = EndPoints.cart + "/\(id)"
        } else {
        requestUrl = EndPoints.cart + "/\(id)" + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.deleteDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                 completionHandler(response.message,nil)
                } else {
                 completionHandler(nil,response.message)
                }
            }
        }
    }
    func updateCartRequest(id:String,qty:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
        requestUrl = EndPoints.cart + "/\(id)?quantity=\(qty)"
        } else {
        requestUrl = EndPoints.cart + "/\(id)?quantity=\(qty)" + "&device_id=" + DeviceInfo.deviceUDID
        }

        webServiceManager.patchDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    //let cartData = CartDataModel().parseCartData(JSON(response.data["data"] as Any))
                
                    completionHandler(response.message,nil)
                } else {
                 completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func moveItemToWishlist(_ id:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.move_to_wishlist + id
        } else {
            requestUrl = EndPoints.move_to_wishlist + id + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                completionHandler(response.message,nil)
                } else {
                 completionHandler(nil,response.message)
                }
            }
        }
    }
    
    
}


