//
/**
 *
 *@copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *@author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import UIKit
import SwiftyJSON

class SplashVM: NSObject {
    let webServiceManager = WebServices.shared
    func getUserProfile(completionHandler:@escaping(_ response:UserProfileDataModel?,_ error:String?)->()){
        let requestUrl = EndPoints.detailUser
        webServiceManager.getDataRequest(urlString: requestUrl, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let user = UserProfileDataModel.parseUserData(JSON(response.data["data"]!))
                    completionHandler(user,nil)
                } else {
                    UserDefaults.standard.set(nil, forKey: "accessToken")
                    UserDefaults.standard.synchronize()
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
}
