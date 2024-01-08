//
//  ShippingMethodDataModel.swift
//  Luban
//
//  Created by King on 12/21/20.
//

import SwiftyJSON

class ShippingMethodDataModel{
    var slug:String?
    var title:String?
    var desc:String?
    
    static func parseDataFromJson(_ json:JSON) -> ShippingMethodDataModel{
        let data = ShippingMethodDataModel()
        data.slug = json["slug"].stringValue
        data.title = json["title"].stringValue
        data.desc = json["desc"].stringValue
        return data
    }
}
