//
//  UploadWinServiceManager.swift
//  Luban
//
//  Created by MAC on 04/10/20.
//

import Foundation
import UIKit

class UploadWinServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func UploadAndWinApiRequest(name:String,address:String,email:String,phone:String,image_Before:[UIImage],image_after:[UIImage],image_invoice:UIImage,completionHandler:@escaping(_ response:String?,_ error:String?)->()){
        
        let urlRequest = EndPoints.uploadWin //+ "?device_id=" + DeviceInfo.deviceUDID
        
        let param:[String:String] = ["first_name":name,"address":address,"email":email,"phone":"1211211213"]
        
        
        webServiceManager.postMultipartDataRequest(urlString: urlRequest, params: param, imageBefore: image_Before, imageAfter: image_after, invoice: image_invoice, showIndicator: true) { (response) in
                    DispatchQueue.main.async {
                        if response.success{
                            let product = response.message
                            completionHandler(product,nil)
                        } else {
                            completionHandler(nil,response.message)
                        }
                    }
                }
        
        
        
//        let requestUrl = EndPoints.wishlist + "/\(product)" + "?device_id=" + DeviceInfo.deviceUDID
//
//        webServiceManager.postDataRequest(urlString: requestUrl, params: ["":""], showIndicator: true) { (response) in
//            DispatchQueue.main.async {
//                if response.success{
//                    let product = response.message
//                    completionHandler(product,nil)
//                } else {
//                    completionHandler(nil,response.message)
//                }
//            }
//        }
    }
    
}
