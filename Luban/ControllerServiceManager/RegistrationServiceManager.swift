//
//  RegistrationServiceManager.swift
//  Luban
//
//  Created by Ganesh Sharma on 10/06/20.
//

import Foundation
import SwiftyJSON

class RegistrationServiceManager{
    
    var registrationData = RegistrationDataModel()
    let webServiceManager = WebServices.shared
    func registrationApiRequest(complitionHandler: @escaping(ApiResponse)->()){
        webServiceManager.postDataRequest(urlString: EndPoints.registerNewUser, params: self.generatingSignUpPapram(), showIndicator: true) { (response) in
            DispatchQueue.main.async {
                complitionHandler(response)
            }
        }
        
    }
    
    func getDropDownApi(completionHandler:@escaping(_ response:DropDownDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.register_dropdown
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let dropDown = DropDownDataModel().parseDropDownData(JSON(response.data["data"]!))
                    completionHandler(dropDown,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }

    func getStateListApi(_ id:Int,completionHandler:@escaping(_ response:DropDownDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.country_state + "\(id)"
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let dropDown = DropDownDataModel().parseDropDownData(JSON(response.data["data"]!))
                    completionHandler(dropDown,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func getShippingMethodApi(_ id:Int,completionHandler:@escaping(_ response:DropDownDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.country_state + "\(id)"
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success {
                    let dropDown = DropDownDataModel().parseDropDownData(JSON(response.data["data"]!))
                    completionHandler(dropDown,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func loginCallRequestApi(_ userName:String,_ password:String,completionHandler:@escaping(_ response:UserProfileDataModel?,_ error:String?)->()){
        let param = ["email":userName,"password":password,"token":"adjhajshdj","device_type":"1","device_id":DeviceInfo.deviceUDID]
        let requestUrl = EndPoints.loginRequest
        webServiceManager.postDataRequest(urlString: requestUrl, params: param, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let user = UserProfileDataModel.parseUserData(JSON(response.data["data"]!))
                    completionHandler(user,nil)
                }else{
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func gettingDataFromUI(_ dataModel:RegistrationDataModel){
        self.registrationData = dataModel
    }
    
    func generatingSignUpPapram() -> [String:Any]{
        var param = [String:Any]()
        param["f_name"] = self.registrationData.f_name
        param["l_name"] = self.registrationData.l_name
        param["already_registered"] = self.registrationData.isAlreadyRegistered
        param["account_manager"] = self.registrationData.accountManager
        param["website"] = self.registrationData.website
        param["company"] = self.registrationData.company
        param["address_1"] = self.registrationData.address_1
        param["address_2"] = self.registrationData.address_2
        param["city"] = self.registrationData.city
        param["state"] = self.registrationData.state
        param["zipcode"] = self.registrationData.zipcode
        param["country"] = self.registrationData.country
        param["phone"] = self.registrationData.phone
        param["email"] = self.registrationData.email
        param["fax"] = self.registrationData.fax
        param["user_type"] = registrationData.userType
        param["heard_from"] = self.registrationData.heard_from
        return param
    }
    
}
