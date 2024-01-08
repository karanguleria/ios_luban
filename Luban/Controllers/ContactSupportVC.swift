//
//  ContactSupportVC.swift
//  Luban
//
//  Created by King on 1/8/21.
//

import UIKit

class ContactSupportVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var txtFldCountry: UITextField!
    @IBOutlet weak var txtFldState: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldZip: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldReasonForContact: UITextField!
    @IBOutlet weak var txtViewNotes: UITextView!
    @IBOutlet weak var imgViewSecond: UIImageView!
    @IBOutlet weak var imgViewFirst: UIImageView!
    @IBOutlet weak var imgViewThird: UIImageView!
    
    
    var objSupportVM = ContactSupportVM()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objSupportVM.pickerView.dataSource = self
        objSupportVM.pickerView.delegate = self
        txtFldCountry.inputView = objSupportVM.pickerView
        txtFldState.inputView = objSupportVM.pickerView
        txtFldReasonForContact.inputView = objSupportVM.pickerView
        objSupportVM.getCountryDropDown()
    }
    
    //MARK:- Actions
    
    @IBAction func actionSubmit(_ sender: UIButton) {
        if validateInput(){
            var param = [String:String]()
            param["first_name"] = txtFldFirstName.text!
            param["last_name"] = txtFldLastName.text!
            param["email"] = txtFldEmail.text!
            param["phone"] = txtFldPhone.text!
            param["address"] = txtFldAddress.text!
            param["city"] = txtFldState.text!
            param["state"] = objSupportVM.selState
            param["country"] = "\(txtFldCountry.tag)"
            param["postal"] = txtFldZip.text!
            param["subject"] = txtFldReasonForContact.text!
            param["message"] = txtViewNotes.text!
            objSupportVM.contactApiRequest(param, attachment: objSupportVM.attachment) {
                self.pop()
            }
            
       
    }
    }
    
    @IBAction func actionUploadImage(_ sender: UIButton) {
       objSupportVM.imageController.delegate = self
        objSupportVM.selectedImage = sender.tag
        objSupportVM.imageController.sourceType = .photoLibrary
        self.present(objSupportVM.imageController, animated: true, completion: nil)
//        objSupportVM.imageController.delegate = self
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
    
    func validateInput() -> Bool {
        if (txtFldFirstName.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your name",title: "Error")
        } else if (txtFldEmail.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter email address",title: "Error")
        } else if !(txtFldEmail.text!.isValidEmail()) {
            Proxy.shared.displayStatusCodeAlert("Please enter valid email address",title: "Error")
        }  else if (txtFldCountry.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your country",title: "Error")
        } else if (txtFldState.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your State",title: "Error")
        } else if (txtFldAddress.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your address",title: "Error")
        } else if (txtFldCity.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your city",title: "Error")
        } else if (txtFldZip.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your zipcode",title: "Error")
        } else if (txtFldPhone.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please enter your phone number",title: "Error")
        } else if (txtFldPhone.text!.count < 10) {
            Proxy.shared.displayStatusCodeAlert("Please enter valid phone number",title: "Error")
        } else if (txtFldReasonForContact.text!.isBlank) {
            Proxy.shared.displayStatusCodeAlert("Please select one reason for contact",title: "Error")
        }else {
            return true
        }
        return false
    }
}
