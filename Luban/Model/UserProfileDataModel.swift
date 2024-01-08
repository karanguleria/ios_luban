//
//  UserProfileDataModel.swift
//  Luban
//
//  Created by Ganesh Sharma on 26/06/20.
//


import Foundation
import SwiftyJSON

 
// MARK: - DataClass
class UserProfileDataModel {
    var id: Int?
    var roleID: String?
    var name:String?
    var fName:String?
    var lName:String?
    var email:String?
    var title: String?
    var website: String?
    var company:String?
    var city:String?
    var address1:String?
    var address2: String?
    var state:String?
    var country:String?
    var phone:String?
    var fax: String?
    var userType:String?
    var heardFrom:String?
    var avatar:String?
    var accountManager: String?
    var accountManagerPhone:String?
    var accountManagerEmail: String?
    var discountRate:Int?
    var taxRate: Int?
    var businessLicenseExpirationDate:String?
    var resellerPermitExpirationDate: String?
    var active: Int?
    var accessToken:String?
    var tokenType:String?
    var expiresAt: String?
    var zipCode: String?
    var countryName: String?
    var stateName: String?

    static func parseUserData(_ dataModel:JSON) -> UserProfileDataModel{
        let model = UserProfileDataModel()
        model.id = dataModel["id"].intValue
        model.roleID = dataModel["role_id"].stringValue
        model.name = "\(dataModel["f_name"].stringValue) \(dataModel["l_name"].stringValue)"
        model.fName = dataModel["f_name"].stringValue
        model.lName = dataModel["l_name"].stringValue
        model.email = dataModel["email"].stringValue
        model.title = dataModel["title"].stringValue
        model.website = dataModel["website"].stringValue
        model.company = dataModel["company"].stringValue
        model.city = dataModel["city"].stringValue
        model.address1 = dataModel["address_1"].stringValue
        model.address2 = dataModel["address_2"].stringValue
        model.state = dataModel["state"].stringValue
        model.country = dataModel["country"].stringValue
        model.phone = dataModel["phone"].stringValue
        model.fax = dataModel["fax"].stringValue
        model.userType = dataModel["user_type"].stringValue
        model.heardFrom = dataModel["heard_from"].stringValue
        model.avatar = dataModel["avatar"].stringValue
        model.accountManager = dataModel["account_manager"].stringValue
        model.accountManagerPhone = dataModel["account_manager_phone"].stringValue
        model.accountManagerEmail = dataModel["account_manager_email"].stringValue
        model.businessLicenseExpirationDate = dataModel["business_license_expiration_date"].stringValue
        model.discountRate = dataModel["discount_rate"].intValue
        model.taxRate = dataModel["tax_rate"].intValue
        model.active = dataModel["active"].intValue
        model.resellerPermitExpirationDate = dataModel["reseller_permit_expiration_date"].stringValue
        model.accessToken = dataModel["access_token"].stringValue
        model.tokenType = dataModel["token_type"].stringValue
        model.expiresAt = dataModel["expires_at"].stringValue
        model.zipCode = dataModel["zipcode"].stringValue
        model.countryName = dataModel["country_name "].stringValue
        model.stateName = dataModel["state_name"].stringValue
        UserInfo.shared.member = model
        return model
    }
    
}

class UserInfo {

    // Now Global.sharedGlobal is your singleton, no need to use nested or other classes
    static let shared = UserInfo()

    var testString: String="Test" //for debugging

    var member = UserProfileDataModel()

}
