//
//  HomeCategoryServiceManager.swift
//  Luban
//
//  Created by King on 8/14/20.
//

import Foundation
import SwiftyJSON

class HomeCategoryServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getHomeCategory(completionHandler:@escaping(_ response:HomeCategoryDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.homeCategory
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let home = HomeCategoryDataModel().parseDatafromJson(JSON(response.data["data"]!))
                    DispatchQueue.main.async {
                        completionHandler(home,nil)
                    }
                    
                } else {
                    DispatchQueue.main.async {
                    
                    completionHandler(nil,response.message)
                    }
                }
            }
        }
    }
    
    func getCategoryFromSlug(_ slug:String, param: [String:AnyObject], completionHandler:@escaping(_ response:HomeCategoryDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.category + slug
        webServiceManager.postDataRequest(urlString: requestUrl, params: param, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let home = HomeCategoryDataModel().parseDatafromJson(JSON(response.data["data"]!))
                    completionHandler(home,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    
    
    func getDealerDetail(_ id:Int,completionHandler:@escaping(_ response:DealerDetailModel?,_ error:String?)->()){
        let requestUrl = EndPoints.storeDetail + "/\(id)"
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            if let dictData = response.data["data"] as? NSDictionary {
                let dealerDetail = DealerDetailModel()
                dealerDetail.getDealerDict(dictData: dictData)
                completionHandler(dealerDetail,nil)
            }else{
                completionHandler(nil,response.message)
            }
        }
    }
    
}
