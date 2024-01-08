//
//  ForgotPasswordVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 03/06/20.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    //MARK:- Actions
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewCustomMethod.setCircleBorder(emailView)
        ViewCustomMethod.setBtnCircleBorder(sendBtn)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Actions
    @IBAction func sendTapped(_ sender: Any) {
        if tf_email.text!.isBlank{
            Proxy.shared.displayStatusCodeAlert("Please enter email address",title: "Error")
        } else if !tf_email.text!.isValidEmail(){
            Proxy.shared.displayStatusCodeAlert("Please enter valid email address",title: "Error")
        } else {
            let param = ["email":tf_email.text!] as [String:Any]
            WebServices.shared.postDataRequest(urlString: EndPoints.forgotPassword, params: param, showIndicator: true) { (response) in
                DispatchQueue.main.async {
                    if response.success {
                    Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Success")
                        self.pop()
                    } else {
                        Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
                    }
                }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
