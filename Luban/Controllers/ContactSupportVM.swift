//
//  ContactSupportVM.swift
//  Luban
//
//  Created by King on 1/15/21.
//

import UIKit

class ContactSupportVM: NSObject {
  var selState = String()
  var pickerView = UIPickerView()
  var selectedImage = Int()
  var imageController = UIImagePickerController()
  var countryValues = [CountryDropDownModel]()
  var stateListDataModel = [StateListDataModel]()
  var registrationServiceManager = RegistrationServiceManager()
  var arrReason = ["General product inquiry","Question about an existing order","Warranty","Need to find a dealer","Other"]
  var attachment = [UIImage]()
    func getCountryDropDown(){
        registrationServiceManager.getDropDownApi { (dropDowns, error) in
            if error != nil{
                
            } else {
                self.countryValues = dropDowns?.countryDropDownModel ?? []
                self.pickerView.reloadAllComponents()
            }
        }
    }
    func getStateList(_ countryId:Int){
        self.stateListDataModel.removeAll()
        registrationServiceManager.getStateListApi(countryId) { (stateList, error) in
            if error != nil{
                
            } else {
                self.stateListDataModel = stateList?.stateListDataModel ?? []
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    func contactApiRequest(_ param:[String:String],attachment:[UIImage],completionHandler:@escaping()->()){
        WebServices.shared.postContactDataRequest(urlString: EndPoints.contactUs, params: param, attachment: attachment, showIndicator: true) { (response) in
            if response.success{
               Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Success")
                completionHandler()
            } else {
                Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
            }
       }
    }
    
    
}

extension ContactSupportVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var noOfRaws = Int()
        if pickerView.tag == 1 {
            noOfRaws = objSupportVM.countryValues.count
        } else if pickerView.tag == 2 {
            noOfRaws = objSupportVM.stateListDataModel.count
        } else if pickerView.tag == 3 {
            noOfRaws = objSupportVM.arrReason.count
        }
        return noOfRaws
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rawTitle = String()
        if pickerView.tag == 1 {
            rawTitle = objSupportVM.countryValues[row].name
        } else if pickerView.tag == 2 {
            rawTitle = objSupportVM.stateListDataModel[row].name
        } else if pickerView.tag == 3 {
            rawTitle = objSupportVM.arrReason[row]
        }
        return rawTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            txtFldCountry.text = objSupportVM.countryValues[row].name
            txtFldCountry.tag = objSupportVM.countryValues[row].id
        } else if pickerView.tag == 2 {
            txtFldState.text = objSupportVM.stateListDataModel[row].name
            objSupportVM.selState = objSupportVM.stateListDataModel[row].shortname
        } else if pickerView.tag == 3 {
            txtFldReasonForContact.text = objSupportVM.arrReason[row]
        }
    }
    
}
extension ContactSupportVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case txtFldCountry:
            objSupportVM.pickerView.tag = 1
            if objSupportVM.countryValues.count>0 {
                txtFldCountry.text = objSupportVM.countryValues[0].name
                txtFldCountry.tag = objSupportVM.countryValues[0].id
            }
        case txtFldState:
            objSupportVM.pickerView.tag = 2
            objSupportVM.getStateList(txtFldCountry.tag)
            if objSupportVM.stateListDataModel.count>0 {
                txtFldCountry.text = objSupportVM.stateListDataModel[0].name
                objSupportVM.selState = objSupportVM.stateListDataModel[0].shortname
            }
        case txtFldReasonForContact:
            objSupportVM.pickerView.tag = 3
            if objSupportVM.arrReason.count>0 {
                txtFldReasonForContact.text = objSupportVM.arrReason[0]
            }
        default:
            break
        }
        return true
    }
   
}
extension ContactSupportVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if objSupportVM.selectedImage == 1 {
                imgViewFirst.image = image
                objSupportVM.attachment.append(image)
            } else if objSupportVM.selectedImage == 2 {
                imgViewSecond.image = image
                objSupportVM.attachment.append(image)
            } else if objSupportVM.selectedImage == 3 {
                imgViewThird.image = image
                objSupportVM.attachment.append(image)
            }
            objSupportVM.imageController.dismiss()
        self.viewWillAppear(true)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        objSupportVM.imageController.dismiss()
    }
}
}
