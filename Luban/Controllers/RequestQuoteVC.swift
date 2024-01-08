//
//  RequestQuoteVC.swift
//  Luban
//
//  Created by King on 12/3/20.
//

import UIKit

class RequestQuoteVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtViewComment: UITextView!
    @IBOutlet weak var txtFldZip: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    var store_id:String?
    var objRequest = RequestQuoteVM()
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Actions
    @IBAction func actionSubmit(_ sender: UIButton) {
        if validateInput(){
            guard let storeId = store_id else {
                return
            }
            var param = [String:Any]()
            param["firstname"] = txtFldFirstName.text!
            param["lastname"] = txtFldLastName.text!
            param["email"] = txtFldEmail.text!
            param["phone"] = txtFldPhone.text!
            param["zip"] = txtFldZip.text!
            param["comments"] = txtViewComment.text!
            param["store_id"] = storeId
            objRequest.requestQuoteApi(param) {
                
                self.dismiss()
            }
        }
    }
    
    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismiss()
    }
    
    
    
    func validateInput() -> Bool {
        if (txtFldFirstName.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your first name",title: "Error")
        } else if (txtFldLastName.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your last name",title: "Error")
        } else if (txtFldPhone.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your phone number",title: "Error")
        } else if (txtFldPhone.text!.count ?? 0<10){
            Proxy.shared.displayStatusCodeAlert("Please enter valid phone number",title: "Error")
        } else if (txtFldEmail.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter email address",title: "Error")
        } else if !(txtFldEmail.text!.isValidEmail()){
            Proxy.shared.displayStatusCodeAlert("Please enter valid email address",title: "Error")
        } else if (txtFldZip.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your zipcode",title: "Error")
        } else {
            return true
        }
        return false
    }
}
