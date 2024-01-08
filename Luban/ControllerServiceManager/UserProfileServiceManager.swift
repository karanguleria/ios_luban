//
//  UserProfileServiceManager.swift
//  Luban
//
//  Created by Ganesh Sharma on 10/06/20.
//

import Foundation
import SwiftyJSON

class UserProfileServiceManager{
    
    let webServiceManager = WebServices.shared
    
    func getUserProfile(completionHandler:@escaping(_ response:UserProfileDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.detailUser
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: false) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let user = UserProfileDataModel.parseUserData(JSON(response.data["data"]!))
                    completionHandler(user,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    func changePasswordRequest(oldPassword:String,newPassword:String,completionHandler:@escaping(_ response:ApiResponse?,_ error:String?)->()){
        let requestUrl = EndPoints.change_password
        
        let param = ["current_password":oldPassword,"password":newPassword]
        webServiceManager.postDataRequest(urlString: requestUrl, params: param, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                  //  let user = UserProfileDataModel.parseUserData(JSON(response.data["data"]!))
                    completionHandler(response,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
        
    }
    
}
