//
//  CheckOutVC.swift
//  Luban
//
//  Created by King on 11/15/20.
//

import UIKit

class CheckOutVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldCompany: UITextField!
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var txtFldCountry: UITextField!
    @IBOutlet weak var txtFldState: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldZip: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldWebsite: UITextField!
    @IBOutlet weak var tfModificationNote: UITextField!
    @IBOutlet weak var txtViewNotes: UITextView!
    @IBOutlet weak var txtFldShippingMethod: UITextField!
    @IBOutlet weak var txtFldShippingName: UITextField!
    @IBOutlet weak var txtFldShippingAddress: UITextField!
    @IBOutlet weak var txtFldShippingPhone: UITextField!
    @IBOutlet weak var txtFldShippingZipcode: UITextField!
    @IBOutlet weak var txtFldShippingCity: UITextField!
    @IBOutlet weak var txtFldShipingState: UITextField!
    @IBOutlet weak var txtFldSippingCountry: UITextField!
    @IBOutlet weak var viewForButtonSameAdd: UIView!
    @IBOutlet weak var viewForBillingAddress: UIView!
    @IBOutlet weak var cnstHeightForBillingBtn: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightForViewShipping: NSLayoutConstraint!
    @IBOutlet weak var lblForAcceptTerms: UILabel!
    @IBOutlet weak var viewForShippingNotes: UIView!
    @IBOutlet weak var lblForShippingNotes: UILabel!
    @IBOutlet weak var btnSameShipping: UIButton!
    @IBOutlet weak var btnAcceptTerms: UIButton!
    @IBOutlet weak var lblTaxTitle: UILabel!
    @IBOutlet weak var lblDiscountTitle: UILabel!
    @IBOutlet weak var cnstHeightForModiView: NSLayoutConstraint!
    @IBOutlet weak var viewForModificatinNote: UIView!
    @IBOutlet weak var assemblyNoBtn: UIButton!
    @IBOutlet weak var txtFldShippingDate: UITextField!
    @IBOutlet weak var modificationNoBtn: UIButton!
    @IBOutlet weak var modificationYesBtn: UIButton!
    @IBOutlet weak var assemblyYesBtn: UIButton!
    @IBOutlet weak var txtFldJobName: UITextField!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lbl_deliveryFee: UILabel!
    @IBOutlet weak var lbl_texPrice: UILabel!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lbldeliveryFeeTitle: UILabel!
    @IBOutlet weak var txtFldAccountManager: UITextField!
    
    @IBOutlet weak var lblProductCount: UILabel!
    var registrationServiceManager = RegistrationServiceManager()
    var objCheckOut = CheckoutVM()
    var cartDataModel:CartDataModel?
    let objUserDet = UserInfo.shared.member
    var deliveryFeeBool = false
    
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objCheckOut.pickerView.dataSource = self
        objCheckOut.pickerView.delegate = self
        txtFldCountry.inputView = objCheckOut.pickerView
        txtFldState.inputView = objCheckOut.pickerView
        txtFldShippingMethod.inputView = objCheckOut.pickerView
        txtFldSippingCountry.inputView = objCheckOut.pickerView
        txtFldShipingState.inputView = objCheckOut.pickerView
        txtFldShippingDate.inputView = objCheckOut.datePicker
        objCheckOut.datePicker.datePickerMode = .date
        objCheckOut.datePicker.minimumDate = Date()
        createAttributeStrCondition()
        objCheckOut.getCountryDropDown()
        objCheckOut.getShippingMethod()
        setBillingDetails()
        lbldeliveryFeeTitle.isHidden = true
        lbl_deliveryFee.isHidden = true
        lblProductCount.text = "Price Details (\(cartDataModel?.itemCount ?? 1) Items)"
        objCheckOut.datePicker.addTarget(self, action: #selector(selectShippingDate), for: .valueChanged)
    }
    
    //MARK:- Actions
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
    
    @IBAction func actionSubmit(_ sender: UIButton) {
        if validateInput(){
            var param = [String:Any]()
            param["email"] = txtFldEmail.text!
            param["company_name"] = txtFldCompany.text!
            param["name"] = txtFldName.text!
            param["phone"] = txtFldPhone.text!
            param["address"] = txtFldAddress.text!
            param["province"] = objCheckOut.selState
            param["postalcode"] = txtFldZip.text!
            param["shipping"] = objCheckOut.selectedShippingMethod
            param["different_shipping_address"] = btnSameShipping.isSelected ? "on" : "off"
            param["notes"] = txtViewNotes.text!
            param["account_manager"] = txtFldAccountManager.text!
            param["assembly"] = assemblyYesBtn.isSelected
            param["modification"] = modificationYesBtn.isSelected
            param["modification_note"] = tfModificationNote.text!
            param["ship_date"] = txtFldShippingDate.text!
            param["job_name"] = txtFldJobName.text!
            if btnSameShipping.isSelected{
                param["s_name"] = txtFldName.text!
                param["s_address"] = txtFldAddress.text!
                param["s_city"] = txtFldCity.text!
                param["s_province"] = objCheckOut.selShippingState
                param["s_country"] = txtFldCountry.tag
                param["s_postalcode"] = txtFldZip.text!
                param["s_phone"] = txtFldPhone.text!
            }else{
                param["s_name"] = txtFldShippingName.text!
                param["s_address"] = txtFldShippingAddress.text!
                param["s_city"] = txtFldShippingCity.text!
                param["s_province"] = objCheckOut.selShippingState
                param["s_country"] = txtFldSippingCountry.tag
                param["s_postalcode"] = txtFldShippingZipcode.text!
                param["s_phone"] = txtFldShippingPhone.text!
            }
            
            objCheckOut.checkoutApiRequest(param) { msg in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Proxy.shared.displayStatusCodeAlert(msg, title: "Success")
                }
                self.rootWithDrawer(identifier: "TabBarVC")
                
            }
        }
    }
    @objc func selectShippingDate(_ sender: UIDatePicker){
        txtFldShippingDate.text = Proxy.shared.changeDateFormat("\(sender.date)", oldFormat: "yyyy-MM-dd HH:mm:ss z", dateFormat: "yyyy-MM-dd")
    }
    func callingGetShippingFeeApi(_ sameShipping:Bool){
        var param = [String:Any]()
        
        if sameShipping{
            param["address"] = "\(txtFldAddress.text ?? "") \(txtFldCity.text ?? "") \(txtFldState.text ?? "") \(txtFldZip.text ?? "") \(txtFldCountry.text ?? "")"
        }else{
            param["address"] = "\(txtFldShippingAddress.text ?? "") \(txtFldShippingCity.text ?? "") \(txtFldShipingState.text ?? "") \(txtFldShippingZipcode.text ?? "") \(txtFldSippingCountry.text ?? "")"
        }
        objCheckOut.getShippingCostApiRequest(param) { (datamodel, error) in
            if error != nil {
                self.deliveryFeeBool = false
                Proxy.shared.displayStatusCodeAlert(error!, title: "Alert")
                self.lbldeliveryFeeTitle.isHidden = true
                self.lbl_deliveryFee.isHidden = true
            }else{
                self.deliveryFeeBool = true
                self.lbldeliveryFeeTitle.isHidden = false
                self.lbl_deliveryFee.isHidden = false
                self.lbl_deliveryFee.text = "\(datamodel?.price ?? "")"
                self.lbl_totalPrice.text = "\(datamodel?.total ?? "")"
            }
        }
    }
    
    @IBAction func modificationBtnPressed(_ sender: UIButton) {
        modificationNoBtn.isSelected = false
        modificationYesBtn.isSelected = false
        sender.isSelected = !sender.isSelected
        viewForModificatinNote.isHidden = !modificationYesBtn.isSelected
        cnstHeightForModiView.constant = modificationYesBtn.isSelected ? 50.0 : 0.0
    }
    
    @IBAction func asswmblyBtnPressed(_ sender: UIButton) {
        assemblyNoBtn.isSelected = false
        assemblyYesBtn.isSelected = false
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
    @IBAction func actionAcceptTerms(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func actionSameBillingAdddress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewForBillingAddress.isHidden = sender.isSelected
        cnstHeightForViewShipping.constant = sender.isSelected ? 0 : 300
        if sender.isSelected == true{
            self.callingGetShippingFeeApi(true)
        }
    }
    //MARK:- Custom methods
    func setBillingDetails(){
        txtFldName.text =  objUserDet.name
        txtFldEmail.text = objUserDet.email
        txtFldZip.text = objUserDet.zipCode
        txtFldCity.text = objUserDet.city
        txtFldState.text = objUserDet.stateName
        txtFldPhone.text = objUserDet.phone
        txtFldCountry.text = objUserDet.countryName
        txtFldCountry.tag = Int(objUserDet.country ?? "0")!
        txtFldCompany.text = objUserDet.company
        txtFldAddress.text = objUserDet.address1
        txtFldWebsite.text = objUserDet.website
        txtFldShippingName.text = objUserDet.name
        txtFldShippingAddress.text = objUserDet.address1
        txtFldShippingCity.text = objUserDet.city
        txtFldShippingPhone.text = objUserDet.phone
        txtFldShippingZipcode.text = objUserDet.zipCode
        txtFldShipingState.text = objUserDet.stateName
        txtFldSippingCountry.text = objUserDet.countryName
        txtFldSippingCountry.tag = Int(objUserDet.country ?? "0")!
        
        guard let cartData = cartDataModel else{
            return
        }
        self.lblDiscount.text = "\(cartData.discount ?? "")"
        self.lblSubTotal.text = "\(cartData.subtotal ?? "")"
        self.lbl_totalPrice.text = "\(cartData.total ?? "")"
        
        self.lbl_texPrice.text = "\(cartData.tax ?? "")"
        self.lblDiscountTitle.text = cartData.couponCode == "" ? "Discount: " : "Discount: (\(cartData.couponCode ?? ""))"
        self.lblTaxTitle.text = cartData.taxRate == "" ? "Tax" : "Tax : \(cartData.taxRate ?? "")"
        
    }
    
    private func createAttributeStrCondition() {
        let attributedString = NSMutableAttributedString(string: "I have read and accept the ", attributes: [
            .font: UIFont.systemFont(ofSize: 17.0),
            .foregroundColor: UIColor.lightGray
        ])
        let attributedStringOne = NSMutableAttributedString(string: "Return Policy", attributes: [
                                                                .font: UIFont.systemFont(ofSize: 17.0),
                                                                .foregroundColor: UIColor.black
                                                                ,.underlineStyle: NSUnderlineStyle.single.rawValue])
        let attributedStringTwo = NSMutableAttributedString(string: " and ", attributes: [
            .font: UIFont.systemFont(ofSize: 17.0),
            .foregroundColor: UIColor.lightGray
        ])
        let attributedStringThree = NSMutableAttributedString(string: "Terms & Conditions", attributes: [
                                                                .font: UIFont.systemFont(ofSize: 17.0),
                                                                .foregroundColor: UIColor.black
                                                                ,.underlineStyle: NSUnderlineStyle.single.rawValue])
        attributedString.append(attributedStringOne)
        attributedString.append(attributedStringTwo)
        attributedString.append(attributedStringThree)
        lblForAcceptTerms.attributedText = attributedString
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.numberOfTapsRequired = 1
        lblForAcceptTerms.isUserInteractionEnabled = true
        lblForAcceptTerms.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let text = (lblForAcceptTerms.text!)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsWebViewVC") as! AboutUsWebViewVC
        viewController.cameFrom = "SignUp"
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        let returnRange = (text as NSString).range(of: "Return Policy")
        if gestureRecognizer.didTapAttributedTextInLabel(label: lblForAcceptTerms, inRange: termsRange) {
            viewController.title = "Terms and Conditions"
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if gestureRecognizer.didTapAttributedTextInLabel(label: lblForAcceptTerms, inRange: returnRange)  {
            viewController.title = "Return Policy"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    func validateInput() -> Bool {
        if (txtFldEmail.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter email address",title: "Error")
        } else if !(txtFldEmail.text!.isValidEmail()){
            Proxy.shared.displayStatusCodeAlert("Please enter valid email address",title: "Error")
        } else if (txtFldName.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your name",title: "Error")
        } else if (txtFldCountry.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your country",title: "Error")
        } else if (txtFldState.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your State",title: "Error")
        } else if (txtFldAddress.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your address",title: "Error")
        } else if (txtFldCity.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your city",title: "Error")
        } else if (txtFldZip.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your zipcode",title: "Error")
        } else if (txtFldPhone.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter your phone number",title: "Error")
        } else if (txtFldPhone.text!.count < 1){
            Proxy.shared.displayStatusCodeAlert("Please enter valid phone number",title: "Error")
        } else if (txtFldAccountManager.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter account manager name",title: "Error")
        } else if (assemblyNoBtn.isSelected == false && assemblyYesBtn.isSelected == false){
            Proxy.shared.displayStatusCodeAlert("Please choose option for assembly",title: "Error")
        } else if (modificationNoBtn.isSelected == false && modificationYesBtn.isSelected == false){
            Proxy.shared.displayStatusCodeAlert("Please choose option for modification",title: "Error")
        } else if (txtFldShippingMethod.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please select shipping method",title: "Error")
        } else if (txtFldShippingDate.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please select shipping date",title: "Error")
        } else if (txtFldJobName.text!.isBlank){
            Proxy.shared.displayStatusCodeAlert("Please enter job name",title: "Error")
            
        } else if  !btnSameShipping.isSelected && txtFldShippingMethod.text == "Delivery" {
            if txtFldShippingName.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping address name",title: "Error")
            } else if txtFldShippingAddress.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping address",title: "Error")
            } else if txtFldSippingCountry.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping country",title: "Error")
            } else if txtFldShipingState.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping state",title: "Error")
            } else if txtFldShippingCity.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping city",title: "Error")
            } else if txtFldShippingZipcode.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping zipcode",title: "Error")
            } else if txtFldShippingPhone.text!.isBlank {
                Proxy.shared.displayStatusCodeAlert("Please enter shipping phone number",title: "Error")
            } else {
                return true
            }
        } else if !btnAcceptTerms.isSelected {
            Proxy.shared.displayStatusCodeAlert("Please read and accept the Terms and Conditions and Return policy ",title: "Error")
        } else {
            return true
        }
        return false
    }
}
