//
//  ContactUsServiceManager.swift
//  Luban
//
//  Created by MAC on 22/08/20.
//

import Foundation
import SwiftyJSON

class ContactUsServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getContactUsDetail(completionHandler:@escaping(_ response:ContactUsModel?,_ error:String?)->()){
        let requestUrl = EndPoints.contactUs
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let contact = ContactUsModel().parseJsonData(JSON(response.data["data"]!))
                    completionHandler(contact,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
}

