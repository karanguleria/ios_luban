//
//  EditProfileVM.swift
//  Luban
//
//  Created by King on 12/26/20.
//

import UIKit

class EditProfileVM: NSObject {
 var myPickerView = UIPickerView()
 var countryValues = [CountryDropDownModel]()
 var stateListDataModel = [StateListDataModel]()
 var selState = String()
 fileprivate var registrationServiceManager = RegistrationServiceManager()
    func getRegistrationDropDown(){
        registrationServiceManager.getDropDownApi { (dropDowns, error) in
            if error != nil{
                
            } else {
               self.countryValues = dropDowns?.countryDropDownModel ?? []
            }
        }
    }
    
    func getStateList(_ countryId:Int){
        self.stateListDataModel.removeAll()
        registrationServiceManager.getStateListApi(countryId) { (stateList, error) in
            if error == nil{
              self.stateListDataModel = stateList?.stateListDataModel ?? []
                self.myPickerView.reloadAllComponents()
            }
        }
    }
}
extension EditProfileVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField == tf_country {
            objEditProfileVM.myPickerView.tag = 1
        } else if textField == tf_state {
            objEditProfileVM.myPickerView.tag = 2
            objEditProfileVM.getStateList(tf_country.tag)
           
        }
    }
  
    
    func validateInput() -> Bool {
        if tf_companyName.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your company name",title: "Error")
        } else if tf_firstName.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your first name",title: "Error")
        } else if tf_firstName.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your last name",title: "Error")
    
        } else if tf_address1.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your address",title: "Error")
        } else if tf_address2.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your additional address",title: "Error")
        } else if tf_country.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your  city",title: "Error")
        } else if tf_state.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your state",title: "Error")
        } else if tf_zipCode.text!.isBlank {
            Proxy.shared.displayStatusCodeAlert("Please enter your zipcode",title: "Error")
        } else if tf_phone.text!.isBlank  {
            Proxy.shared.displayStatusCodeAlert("Please enter your country",title: "Error")
        } else if (tf_phone.text?.count ?? 0<10){
            Proxy.shared.displayStatusCodeAlert("Please enter valid phone number",title: "Error")
        } else {
            return true
        }
        return false
    }
}

extension EditProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var noOfRaws = Int()
        if pickerView.tag == 1 {
            noOfRaws = objEditProfileVM.countryValues.count
        } else if pickerView.tag == 2 {
            noOfRaws = objEditProfileVM.stateListDataModel.count
        }
        return noOfRaws
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rawTitle = String()
        if pickerView.tag == 1 {
            rawTitle = objEditProfileVM.countryValues[row].name
        } else if pickerView.tag == 2 {
            rawTitle = objEditProfileVM.stateListDataModel[row].name
        }
        return rawTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            tf_country.text = objEditProfileVM.countryValues[row].name
            tf_country.tag = objEditProfileVM.countryValues[row].id
        } else if pickerView.tag == 2 {
            tf_state.text = objEditProfileVM.stateListDataModel[row].name
            objEditProfileVM.selState = objEditProfileVM.stateListDataModel[row].shortname
        }
    }
}
