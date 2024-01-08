//
//  CompareModel.swift
//  Luban
//
//  Created by King on 11/18/20.
//

import UIKit
import SwiftyJSON
class ProductsModel: NSObject {
    var arrComare = [CompareModel]()
    
    func getNewsDict(_ json:JSON) -> ProductsModel{
        let productDataModel = ProductsModel()
        let compData = json["products"].arrayValue
        for cat in compData{
            let category = CompareModel().getNewsDict(cat)
            productDataModel.arrComare.append(category)
        }
        return productDataModel
        }
}
class CompareModel: NSObject {
    var name:String?, image:String?, slug:String?, descriptionString:String?
    var id:Int?
    var arrDiscriptionKeys = [DescriptionKeys]()
    
    func getNewsDict(_ json:JSON) -> CompareModel{
        let compareDataModel = CompareModel()
        compareDataModel.name = json["name"].stringValue
        compareDataModel.image = json["image"].stringValue
        compareDataModel.slug = json["slug"].stringValue
        compareDataModel.descriptionString = json["description"].stringValue
        compareDataModel.id = json["id"].intValue
        let catData = json["description_keys"].arrayValue
        for cat in catData{
            let category = DescriptionKeys().parsekeyData(cat)
            compareDataModel.arrDiscriptionKeys.append(category)
        }
        return compareDataModel
        }
}

