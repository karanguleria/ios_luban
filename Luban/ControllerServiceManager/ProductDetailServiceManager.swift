//
//  ProductDetailServiceManager.swift
//  Luban
//
//  Created by MAC on 29/08/20.
//

import Foundation

import Foundation
import SwiftyJSON

class ProductDetailServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getProductFromSlug(page:Int,cabinate_type:String,sub_cabinate_type:String,slug:Int,completionHandler:@escaping(_ response:ProductDetailDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.product + "\(slug)" + "?device_id=" + DeviceInfo.deviceUDID
        let param = ["cabinate_type":cabinate_type,"sub_cabinate_type":sub_cabinate_type,"page":page] as [String : Any]

        webServiceManager.postDataRequest(urlString: requestUrl, params: param, showIndicator: false) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let product = ProductDetailDataModel().parseDatafromJson(JSON(response.data["data"]!))
                    completionHandler(product,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func addProductToCart(product:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        var requestUrl = String()
        if Proxy.shared.accessTokenNil() != "" {
            requestUrl = EndPoints.cart + "/\(product)"
        } else {
            requestUrl = EndPoints.cart + "/\(product)" + "?device_id=" + DeviceInfo.deviceUDID
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
    func addProductToWishlist(product:String,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
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
    
}
