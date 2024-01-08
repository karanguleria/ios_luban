//
//  NewsModel.swift
//  Luban
//
//  Created by King on 8/16/20.
//

import UIKit

class NewsModel: NSObject {
    var newsDetail = String(), image = String(), title = String()
    var id = Int()
    func getNewsDict(dictData:NSDictionary){
        newsDetail = dictData["description"] as? String ?? ""
        image = dictData["image"] as? String ?? ""
        title = dictData["title"] as? String ?? ""
        id = dictData["id"] as? Int ?? 0
    }
}
class DealerDetailModel: NSObject {
    var accountManager = String(), accountEmail = String(), accountPhone = String(), addressOne = String(), addressTwo = String(), accountImage = String(), licenseExpDate = String(), city = String(), company = String(), userEmail = String(), firstName = String(), fax = String(), lastName = String(), latitude = String(), longitude = String(), userPhone = String(), resellerPermissionExp = String(), state = String(), website = String(), hours = String(), discountRate = String(), state_name = String(),country_name = String(),about = String(),zipcode = String()
    var id = Int(), tax_rate = Int(), country = Int(), active = Int()
    func getDealerDict(dictData:NSDictionary){
        accountManager = dictData["account_manager"] as? String ?? ""
        accountEmail = dictData["account_manager_email"] as? String ?? ""
        accountPhone = dictData["account_manager_phone"] as? String ?? ""
        addressOne = dictData["address_1"] as? String ?? ""
        addressTwo = dictData["address_2"] as? String ?? ""
        accountImage = dictData["avatar"] as? String ?? ""
        licenseExpDate = dictData["business_license_expiration_date"] as? String ?? ""
        city = dictData["city"] as? String ?? ""
        company = dictData["company"] as? String ?? ""
        userEmail = dictData["email"] as? String ?? ""
        firstName = dictData["f_name"] as? String ?? ""
        fax = dictData["fax"] as? String ?? ""
        lastName = dictData["l_name"] as? String ?? ""
        latitude = dictData["latitude"] as? String ?? ""
        longitude = dictData["longitude"] as? String ?? ""
        userPhone = dictData["phone"] as? String ?? ""
        resellerPermissionExp = dictData["reseller_permit_expiration_date"] as? String ?? ""
        userPhone = dictData["title"] as? String ?? ""
        state = dictData["state"] as? String ?? ""
        website = dictData["website"] as? String ?? ""
        hours = dictData["hours"] as? String ?? ""
        discountRate = dictData["title"] as? String ?? ""
        id = dictData["id"] as? Int ?? 0
        tax_rate = dictData["tax_rate"] as? Int ?? 0
        country = dictData["country"] as? Int ?? 0
        active = dictData["active"] as? Int ?? 0
        zipcode = dictData["zipcode"] as? String ?? ""
        country_name = dictData["country_name"] as? String ?? ""
        state_name = dictData["state_name"] as? String ?? ""
        about = dictData["about"] as? String ?? ""
    }
}
