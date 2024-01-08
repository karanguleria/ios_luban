//
//  ContactUsModel.swift
//  Luban
//
//  Created by MAC on 22/08/20.
//

import Foundation
import SwiftyJSON

class ContactUsModel{
    
    var address = String()
    var email = String()
    var phone = String()
    var fax = String()
    var openingTime = String()
    var openingTimeWeekends = String()
    var lat = String()
    var long = String()

    
    func parseJsonData(_ json:JSON) -> ContactUsModel{
        let dataModel = ContactUsModel()
        dataModel.address =  json["address"].stringValue
        dataModel.phone =  json["phone"].stringValue
        dataModel.email =  json["email"].stringValue
        dataModel.fax =  json["fax"].stringValue
        dataModel.lat =  json["lat"].stringValue
        dataModel.long =  json["long"].stringValue
        dataModel.openingTime =  json["openingTime"].stringValue
        dataModel.openingTimeWeekends =  json["openingTimeWeekends"].stringValue
        return dataModel
    }
}
