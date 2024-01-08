//
//  CheckoutVM.swift
//  Luban
//
//  Created by King on 12/11/20.
//

import UIKit
import SwiftyJSON

class CheckoutVM: NSObject {
    var pickerView = UIPickerView()
    var datePicker = UIDatePicker()
    var countryValues = [CountryDropDownModel]()
    var stateListDataModel = [StateListDataModel]()
    var selectedShippingMethod = String()
    var selState = String()
    var selShippingState = String()
    
    var registrationServiceManager = RegistrationServiceManager()
    var shippingMethodArray = [ShippingMethodDataModel]()
    func getCountryDropDown(){
        registrationServiceManager.getDropDownApi { (dropDowns, error) in
            if error != nil{
                
            } else {
                self.countryValues = dropDowns?.countryDropDownModel ?? []
            }
        }
    }
    
    func getShippingMethod(){
        let urlString = EndPoints.shippingMethod
        WebServices.shared.getDataRequest(urlString: urlString, showIndicator: true) { (response) in
            if response.success{
                let data = JSON(response.data)
                let jsonData = data["data"].arrayValue
                for json in jsonData{
                    let model = ShippingMethodDataModel.parseDataFromJson(json)
                    self.shippingMethodArray.append(model)
                }
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
    func checkoutApiRequest(_ param:[String:Any],completionHandler:@escaping(_ msg:String)->()){
        let url = EndPoints.checkout + "?device_id=\(DeviceInfo.deviceUDID)"
        WebServices.shared.postDataRequest(urlString: url, params: param, showIndicator: true) { (response) in
            if response.success{
               
                completionHandler(response.message ?? "")
            } else {
                Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
            }
       }
    }
    
   func getShippingCostApiRequest(_ param:[String:Any],completionHandler:@escaping(_ response:ShippingCostDataModel?,_ error:String?)->()){
        let url = EndPoints.shipping_cost + "?device_id=\(DeviceInfo.deviceUDID)"
        WebServices.shared.postDataRequest(urlString: url, params: param, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success{
                    let dropDown = ShippingCostDataModel().parseShippingCostData(JSON(response.data))//DropDownDataModel().parseDropDownData(JSON(response.data["data"]!))
                    print(dropDown)
                    completionHandler(dropDown,nil)
                } else {
                    completionHandler(nil,response.message)
                }
            }
        }
    }
    
    
}
extension CheckOutVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var noOfRaws = Int()
        if pickerView.tag == 1 {
            noOfRaws = objCheckOut.countryValues.count
        } else if pickerView.tag == 2 {
            noOfRaws = objCheckOut.stateListDataModel.count
        } else if pickerView.tag == 3 {
            noOfRaws = objCheckOut.shippingMethodArray.count
        }else if pickerView.tag == 4 {
            noOfRaws = objCheckOut.countryValues.count
        } else if pickerView.tag == 5 {
            noOfRaws = objCheckOut.stateListDataModel.count
        }
        return noOfRaws
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rawTitle = String()
        if pickerView.tag == 1 {
            rawTitle = objCheckOut.countryValues[row].name
        } else if pickerView.tag == 2 {
            rawTitle = objCheckOut.stateListDataModel[row].name
        } else if pickerView.tag == 3 {
            rawTitle = objCheckOut.shippingMethodArray[row].title ?? ""
        }else if pickerView.tag == 4 {
            rawTitle = objCheckOut.countryValues[row].name
        } else if pickerView.tag == 5 {
            rawTitle = objCheckOut.stateListDataModel[row].name
        }
        return rawTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            txtFldCountry.text = objCheckOut.countryValues[row].name
            txtFldCountry.tag = objCheckOut.countryValues[row].id
        } else if pickerView.tag == 2 {
            txtFldState.text = objCheckOut.stateListDataModel[row].name
            objCheckOut.selState = objCheckOut.stateListDataModel[row].shortname
        } else if pickerView.tag == 3 {
            if row == 1 {
                viewForButtonSameAdd.isHidden = false
                cnstHeightForBillingBtn.constant = 40
                viewForBillingAddress.isHidden = false
                cnstHeightForViewShipping.constant = 300
            } else {
                viewForButtonSameAdd.isHidden = true
                cnstHeightForBillingBtn.constant = 0
                viewForBillingAddress.isHidden = true
                cnstHeightForViewShipping.constant = 0
                self.deliveryFeeBool = false
//                Proxy.shared.displayStatusCodeAlert(error!, title: "Alert")
                self.lbldeliveryFeeTitle.isHidden = true
                self.lbl_deliveryFee.isHidden = true
            }
            viewForShippingNotes.isHidden = false
            txtFldShippingMethod.text = objCheckOut.shippingMethodArray[row].title
            lblForShippingNotes.text = objCheckOut.shippingMethodArray[row].desc
            objCheckOut.selectedShippingMethod = objCheckOut.shippingMethodArray[row].slug!
            txtFldShippingMethod.tag = row
        } else if pickerView.tag == 4 {
            txtFldSippingCountry.text = objCheckOut.countryValues[row].name
            txtFldSippingCountry.tag = objCheckOut.countryValues[row].id
        } else if pickerView.tag == 5 {
            txtFldShipingState.text = objCheckOut.stateListDataModel[row].name
            objCheckOut.selShippingState = objCheckOut.stateListDataModel[row].shortname
        }
    }
    
}
extension CheckOutVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case txtFldCountry:
            objCheckOut.pickerView.tag = 1
            objCheckOut.getCountryDropDown()
        case txtFldState:
            objCheckOut.pickerView.tag = 2
            objCheckOut.getStateList(txtFldCountry.tag)
        case txtFldSippingCountry:
            objCheckOut.pickerView.tag = 4
            objCheckOut.getCountryDropDown()
        case txtFldShipingState:
            objCheckOut.pickerView.tag = 5
            objCheckOut.getStateList(txtFldSippingCountry.tag)
        case txtFldShippingMethod:
            objCheckOut.pickerView.tag = 3
            if objCheckOut.shippingMethodArray.count>0 && txtFldShippingMethod.text == ""{
                viewForShippingNotes.isHidden = false
                txtFldShippingMethod.text = objCheckOut.shippingMethodArray[0].title
                lblForShippingNotes.text = objCheckOut.shippingMethodArray[0].desc
                objCheckOut.selectedShippingMethod = objCheckOut.shippingMethodArray[0].slug!
                viewForButtonSameAdd.isHidden = true
                cnstHeightForBillingBtn.constant = 0
                viewForBillingAddress.isHidden = true
                cnstHeightForViewShipping.constant = 0
                self.deliveryFeeBool = false
//                Proxy.shared.displayStatusCodeAlert(error!, title: "Alert")
                self.lbldeliveryFeeTitle.isHidden = true
                self.lbl_deliveryFee.isHidden = true
            }
        default:
            break
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if btnSameShipping.isSelected{
            if textField == txtFldState{
                self.callingGetShippingFeeApi(true)
            }else if textField == txtFldCity{
                self.callingGetShippingFeeApi(true)
            }else if textField == txtFldCountry{
                self.callingGetShippingFeeApi(true)
            }else if textField == txtFldZip{
                self.callingGetShippingFeeApi(true)
            }else if textField == txtFldAddress{
                self.callingGetShippingFeeApi(true)
            }
            
        }else{
            if textField == txtFldShipingState{
                self.callingGetShippingFeeApi(false)
            }else if textField == txtFldShippingCity{
                self.callingGetShippingFeeApi(false)
            }else if textField == txtFldSippingCountry{
                self.callingGetShippingFeeApi(false)
            }else if textField == txtFldShippingZipcode{
                self.callingGetShippingFeeApi(false)
            }else if textField == txtFldShippingAddress{
                self.callingGetShippingFeeApi(false)
            }
            
        }
    }
}
