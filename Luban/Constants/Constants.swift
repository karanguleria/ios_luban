//
//  Constants.swift
//  Luban
//
//  Created by Ganesh Sharma on 23/03/20.
//

import Foundation
import UIKit

class Constants{
    
    static let appBaseColor = UIColor.init(red: 29/255, green: 86/255, blue: 112/255, alpha: 1)
    
}

enum AppInfo{
    static let mode = "development"
    static let appName = "Project Noosphere"
    static let version =  "1.0"
    static let userAgent = "\(mode)/\(appName)/\(version)"
  //  static let wpKey = "fdsioew209230"
   // static let googleAPIKey = "AIzaSyD9ZVuIFPqaVKfuZLRRS5FPNChYkPitgS8"
   // static let googleClientId = "36954763585-3388238fbragecmptudn1t52d6lmnavk.apps.googleusercontent.com"
}

enum AppColor {
    static let appColor = UIColor(red: 196/255, green: 159/255, blue: 51/255, alpha: 1)  //C49F33
    static let notifyColor = UIColor(red: 73/255, green: 179/255, blue: 239/255, alpha: 1)
}

enum DeviceInfo {
    static let deviceType =  "IOS" //0 or 1
    static let deviceName = UIDevice.current.name
    static let deviceUDID = UIDevice.current.identifierForVendor!.uuidString
}

enum Apis {
    static let serverUrl = "https://www.projectnoosphere.com/"
    static let login = "api/userplus/generate_auth_cookie/?data_format=json&key="
   // static let fbLogin = "api/userplus/fb_connect/?key=\(AppInfo.wpKey)&access_token="
    //static let googleLogin = "api/userplus/google_connect/?key=\(AppInfo.wpKey)&id_token="
    static let signUp = "api/userplus/register/?"
    static let forgotPassword = "api/userplus/retrieve_password/?data_format=json"
    static let contactUs = "wp-json/wpapi/v1/contact-submit?name="
    static let getContactInfo = "wp-json/wpapi/v1/contact-info"
    static let addMarker = "wp-json/wpapi/v1/add-marker"
    static let getMeditation = "wp-json/wpapi/v1/meditaion"
    static let aboutUs = "wp-json/wpapi/v1/about"
    static let webPrivacyPolicy = "https://www.projectnoosphere.com/mobile-privacy-policy/"
    static let webTermsConditions = "https://www.projectnoosphere.com/mobile-terms-conditions/"
   // static let getUserProfile = "api/userplus/get_userinfo/?key=\(AppInfo.wpKey)&user_id="
}

enum StatusCode: Int{
    case  success = 0,error, unknown
}

enum LoginType: Int{
    case  withApp = 0,gmail, facebook, apple
}

struct ApiResponse {
    var data : [String:Any]
    var success: Bool
    var message: String?
}
