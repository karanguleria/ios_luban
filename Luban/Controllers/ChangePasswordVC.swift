//
//  ChangePasswordVC.swift
//  Luban
//
//  Created by MAC on 04/09/20.
//

import UIKit

class ChangePasswordVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var changePassword : UIButton!
    @IBOutlet weak var tf_newPass: UITextField!
    @IBOutlet weak var newPassView: UIView!
    @IBOutlet weak var tf_oldPass: UITextField!
    @IBOutlet weak var oldPassView: UIView!
    
    fileprivate var userProfileServiceManager = UserProfileServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    @IBAction func changePasswordPressed(_ sender: Any) {
      if let old = tf_oldPass.text, let new = tf_newPass.text, old != "" && new != ""{
            userProfileServiceManager.changePasswordRequest(oldPassword: old, newPassword: new) { (response, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                }else{
                    if response?.success == true{
                        self.navigationController?.popViewController(animated: true)
                        Proxy.shared.displayStatusCodeAlert(response?.message ?? "", title: "Success")
                    }
                    
                }
            }
        }
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
