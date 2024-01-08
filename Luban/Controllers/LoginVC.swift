//
//  LoginVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 23/03/20.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var view_password: UIView!
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var view_userName: UIView!
    
    fileprivate let registrationServiceManager = RegistrationServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
      //  settingBtnAndViews()
    }
    
    func settingBtnAndViews(){
        ViewCustomMethod.setCircleBorder(view_password)
        ViewCustomMethod.setCircleBorder(view_userName)
        ViewCustomMethod.setBtnCircleBorder(btn_signin)
    }
    
    //MARK:- Actions
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let signUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let signUpVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func SignInTapped(_ sender: Any) {
        if let username = tf_username.text, let pass = tf_password.text{
            if username != "" && pass != ""{
                registrationServiceManager.loginCallRequestApi(username, pass) { (response, error) in
                    if error != nil{
                        Proxy.shared.displayStatusCodeAlert(error ?? "Invalid Credentials", title: "Error")
                    } else {
                        UserDefaults.standard.setValue(response?.accessToken, forKey: "accessToken")
                       self.rootWithDrawer(identifier: "TabBarVC")
                    }
                }
            } else {
                Proxy.shared.displayStatusCodeAlert("Please enter username and password.", title: "Error")
            }
        }
    }
    @IBAction func guestLoginTapped(_ sender: Any) {
    self.rootWithDrawer(identifier: "TabBarVC")
    }
}
