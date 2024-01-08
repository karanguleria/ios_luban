//
//  WebServices.swift
//  Noosphere
//
//  Created by King on 3/17/20.
//  Copyright © 2020 Karan. All rights reserved.
//
import UIKit
import Foundation
import CRNotifications
import GoogleMaps
//import IQKeyboardManagerSwift
import NVActivityIndicatorView

@available(iOS 13.0, *)
let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
var currentViewCont = UIViewController()
var preferredLang = "en"

class Proxy {
    static var shared: Proxy {
        return Proxy()
    }
    
    fileprivate init(){}
    //MARK:- Common Methods
    func accessTokenNil() -> String {
        if let authCode = UserDefaults.standard.object(forKey: "accessToken") as? String {
            return authCode
        } else {
            return ""
        }
    }
    //MARK:- Common Methods
    func userIdNil() -> Int {
        if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
            return userId
        } else {
            return 0
        }
    }
    
    func loginTypeVal() -> Int {
        if let typeDes = UserDefaults.standard.object(forKey: "login-type") as? Int {
            return typeDes
        } else {
            return 0
        }
    }
    
    //MARK: - HANDLE ACTIVITY
    func showActivityIndicator() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    func hideActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    
    //MARK:- Display Toast
    func displayStatusCodeAlert(_ userMessage: String, title: String = "") {
        switch title {
        case "Success" :
            CRNotifications.showNotification(type: CRNotifications.success, title: title, message: userMessage, dismissDelay: 2)
        case "Error" :
            CRNotifications.showNotification(type: CRNotifications.error, title: title, message: userMessage, dismissDelay: 2)
        default:
            CRNotifications.showNotification(type: CRNotifications.info, title: title, message: userMessage, dismissDelay: 2)
        }
        
    }
    
    //MARK:-  Add Shadow
    func addShadowOnView(_ shadowView:UIView, cornerRadius: CGFloat) {
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOffset =
            CGSize(width:0.5, height:1.0)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 2.0 //Here your control your blur
    }
    
    //MARK:- REGISTER NIB FOR TABLE VIEW
    func registebrTblVwNib(_ tblView: UITableView,identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: identifierCell)
        tblView.tableFooterView = UIView()
    }
    //MARK:- REGISTER NIB FOR COLLECTION VIEW
    func registerClcVwNib(_ collView: UICollectionView,identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        collView.register(nib, forCellWithReuseIdentifier: identifierCell)
    }
    //MARK:- Get 2D Coordinate Of Map
       func getCoordinateOfMap(latitute: String,longitute: String) -> CLLocationCoordinate2D {
           let coodinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitute) ?? 0, longitude: CLLocationDegrees(longitute) ?? 0)
           return coodinate
       }
    
    func openSettingApp() {
        let settingAlert = UIAlertController(title: "Connection Problem", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title:"Settings", style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    Proxy.shared.displayStatusCodeAlert("Please Check your network settings")
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    }
    
    //MARK:- Display Toast
    
    func displaySuccessFailureAlert(_ alertType: CRNotificationType, userMessage: String) {
        let titleAlert = String()
        CRNotifications.showNotification(type: alertType, title: titleAlert, message: userMessage, dismissDelay: 3)
        
    }
    func hitlogoutApi(_ completion:@escaping() -> Void){
        WebServices.shared.getDataRequest(urlString: EndPoints.logoutRequest, showIndicator: true) { (ApiResponse) in
            if ApiResponse.success {
                UserDefaults.standard.set(nil, forKey: "accessToken")
                UserDefaults.standard.synchronize()
                completion()
            } 
        }
    }
    
    //MARK : METHOD FOR HANDLING ALERT"S & PERFEROM ACTION
    func alertControl(title:String, message:String, _ completion:@escaping(_ alert:UIAlertController, _ action:String) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.handleAlert(action: action, { (Bool) in
                if Bool == true{
                    completion(alert, "true")
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            //TODO: self.handleAlert(action:action)
            self.handleAlert(action: action, { (Bool) in
                if Bool == false{
                    completion(alert, "false")
                }
            })
        }))
        completion(alert, " ")
    }
    
    func handleAlert(action:UIAlertAction, _ completion:@escaping(_ action:Bool) -> Void){
        switch action.style{
        case .default:
            completion(true)
        case .cancel:
            completion(false)
        case .destructive:
            print("destructive")
            
        }
    }
    //MARK:- Change Date format
    func changeDateFormat(_ dateStr: String, oldFormat:String, dateFormat:String) -> String{
        if dateStr != ""{
            let dateFormattr = DateFormatter()
            dateFormattr.dateFormat = oldFormat
            let date1 = dateFormattr.date(from: dateStr)
            let dateFormattr1 = DateFormatter()
            dateFormattr1.dateFormat = dateFormat
            var dateNew = String()
            if date1 != nil {
                dateNew = dateFormattr1.string(from: (date1!))
            } else {
                dateNew = dateFormattr1.string(from: (Date()))
            }
            return dateNew
        } else {
            return ""
        }
    }
}
