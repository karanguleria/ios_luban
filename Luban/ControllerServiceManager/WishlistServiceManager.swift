//
//  WishlistServiceManager.swift
//  Luban
//
//  Created by MAC on 27/09/20.
//

import Foundation
import SwiftyJSON

class WishlistServiceManager{
    let webServiceManager = WebServices.shared
    
    func getWishlistItems(completionHandler:@escaping(_ response:CartDataModel?,_ error:String?)->()){
//        let requestUrl = EndPoints.wishlist + "?device_id=" + DeviceInfo.deviceUDID
        
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.wishlist
        } else {
            requestUrl = EndPoints.wishlist + "?device_id=" + DeviceInfo.deviceUDID
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
    
    func addProductToWishlist(product:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
//        let requestUrl = EndPoints.wishlist + "/\(product)" + "?device_id=" + DeviceInfo.deviceUDID
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.wishlist + "/\(product)"
        } else {
            requestUrl = EndPoints.wishlist + "/\(product)" + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.postDataRequest(urlString: requestUrl, params: ["":""], showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let product = response.message
                    completionHandler(product,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func removeFromwishlist(_ id:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
//        let requestUrl = EndPoints.wishlist + "/\(id)" + "?device_id=" + DeviceInfo.deviceUDID
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.wishlist + "/\(id)"
        } else {
            requestUrl = EndPoints.wishlist + "/\(id)" + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.deleteDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
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
    
    
    
    func moveItemToCart(_ id:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
//        let requestUrl = EndPoints.move_to_cart + id + "?device_id=" + DeviceInfo.deviceUDID
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.move_to_cart + id
        } else {
            requestUrl = EndPoints.move_to_cart + id + "?device_id=" + DeviceInfo.deviceUDID
        }
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
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
    
    func getWishlistCount(completionHandler:@escaping(_ response:CartDataModel?,_ error:String?)->()){
//        let requestUrl = EndPoints.wishlist_count + "?device_id=" + DeviceInfo.deviceUDID
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.wishlist_count
        } else {
            requestUrl = EndPoints.wishlist_count + "?device_id=" + DeviceInfo.deviceUDID
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
    func getCartCount(completionHandler:@escaping(_ response:CartDataModel?,_ error:String?)->()){
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
        requestUrl = EndPoints.cart_count
        } else {
        requestUrl = EndPoints.cart_count + "?device_id=" + DeviceInfo.deviceUDID
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
    
}
