//
//  FAQServiceManager.swift
//  Luban
//
//  Created by MAC on 22/08/20.
//

import Foundation
import SwiftyJSON

class FAQServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getContactUsDetail(completionHandler:@escaping(_ response:[FAQDataModel],_ error:String?)->()){
        let requestUrl = EndPoints.contactUs
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let faqData = [FAQDataModel]()
                
                    let contact = ContactUsModel().parseJsonData(JSON(response.data["data"]!))
                 //   completionHandler(contact,nil)
                } else {
                   // completionHandler(nil,response.message)
                }
            }
        }
    }
}
