//
//  RegistrationDataModel.swift
//  Luban
//
//  Created by Ganesh Sharma on 10/06/20.
//

import Foundation
import SwiftyJSON


class RegistrationDataModel{
    var f_name:String?
    var l_name:String?
    var isAlreadyRegistered:Int?
    var accountManager: String?
    var website:String?
    var company:String?
    var address_1:String?
    var address_2:String?
    var city:String?
    var state:String?
    var zipcode:String?
    var country:Int?
    var phone:String?
    var email:String?
    var fax:String?
//    var user_type:Int?
    var heard_from:Int?
    var userType:Int?
    var acceptTerms:Bool?
        
}

class DropDownDataModel{
    
    var countryDropDownModel = [CountryDropDownModel]()
    var userTypeDropDownModel = [UserTypeDropDownModel]()
    var heardFromDropDownModel = [HeardFromDropDownModel]()
    var stateListDataModel = [StateListDataModel]()
    
    func parseDropDownData(_ json:JSON) -> DropDownDataModel{
        let dataModel = DropDownDataModel()
        
        let countryjson = json["country"].arrayValue
        for country in countryjson{
            let countryItem = CountryDropDownModel().parsingCountryData(country)
            dataModel.countryDropDownModel.append(countryItem)
        }
        let uesrTypejson = json["user_type"].arrayValue
        for type in uesrTypejson{
            let userTypeItem = UserTypeDropDownModel().parsingUserTypeData(type)
            dataModel.userTypeDropDownModel.append(userTypeItem)
        }
        let heardFromjson = json["heard_from"].arrayValue
        for heard in heardFromjson{
            let heardItem = HeardFromDropDownModel().parsingHeardFromData(heard)
            dataModel.heardFromDropDownModel.append(heardItem)
        }
        let stateJson = json["state"].arrayValue
        for state in stateJson{
            let stateItem = StateListDataModel().parsingStateListData(state)
            dataModel.stateListDataModel.append(stateItem)
        }
    
        return dataModel
    }
    
}
class CountryDropDownModel{
    var id = Int()
    var name = String()
    
    func parsingCountryData(_ json:JSON) -> CountryDropDownModel{
        let dataModel = CountryDropDownModel()
        dataModel.id = json["id"].intValue
        dataModel.name = json["name"].stringValue
        return dataModel
    }
    
}
class UserTypeDropDownModel{
    var id = Int()
    var name = String()
    
    func parsingUserTypeData(_ json:JSON) -> UserTypeDropDownModel{
        let dataModel = UserTypeDropDownModel()
        dataModel.id = json["id"].intValue
        dataModel.name = json["name"].stringValue
        return dataModel
    }
    
}
class HeardFromDropDownModel{
    var id = Int()
    var name = String()
    
    func parsingHeardFromData(_ json:JSON) -> HeardFromDropDownModel{
        let dataModel = HeardFromDropDownModel()
        dataModel.id = json["id"].intValue
        dataModel.name = json["name"].stringValue
        return dataModel
    }
    
}
class StateListDataModel{
    var shortname = String()
    var name = String()
    
    func parsingStateListData(_ json:JSON) -> StateListDataModel{
        let dataModel = StateListDataModel()
        dataModel.shortname = json["shortname"].stringValue
        dataModel.name = json["name"].stringValue
        return dataModel
    }
    
}
