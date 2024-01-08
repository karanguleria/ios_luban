//
//  SignUpVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 24/03/20.
//

import UIKit
import DropDown

class SignUpVC: UIViewController {
    
    //MARK:- Button Outlet(s)
    @IBOutlet weak var lblAcceptTerms: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var btnRegisterdYes: UIButton!
    @IBOutlet weak var btnRegisteredNo: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK:- Textfield Outlet(s)
    
    @IBOutlet weak var cnstHeightForView: NSLayoutConstraint!
    @IBOutlet weak var viewForAccountManager: UIView!
    @IBOutlet weak var tf_companyName: UITextField!
    @IBOutlet weak var tf_firstName: UITextField!
    @IBOutlet weak var tf_lastName: UITextField!
    @IBOutlet weak var tf_address1: UITextField!
    @IBOutlet weak var tf_address2: UITextField!
    @IBOutlet weak var tf_city: UITextField!
    @IBOutlet weak var txtFieldAccountManager: UITextField!
    @IBOutlet weak var tf_state: UITextField!{
        didSet{
            tf_state.delegate = self
            tf_state.tintColor = .clear
        }
    }
    @IBOutlet weak var txtFieldFax: UITextField!
    @IBOutlet weak var tf_zipCode: UITextField!
    @IBOutlet weak var tf_country: UITextField!{
        didSet{
            tf_country.delegate = self
            tf_country.tintColor = .clear
        }
    }
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_website: UITextField!
    @IBOutlet weak var tf_gender: UITextField!{
        didSet{
            tf_gender.delegate = self
            tf_gender.tintColor = .clear
        }
    }
    
    @IBOutlet weak var tf_reference: UITextField!{
        didSet{
            tf_reference.delegate = self
            tf_reference.tintColor = .clear
        }
    }
    
    lazy var myPickerView = UIPickerView()
    var referenceDropDown = DropDown()
    var roleDropDown = DropDown()
    var countryDropDown = DropDown()
    var stateDropDown = DropDown()
    var heard_fromValues = [HeardFromDropDownModel]()
    var user_typeValues = [UserTypeDropDownModel]()
    var countryValues = [CountryDropDownModel]()
    var stateListDataModel = [StateListDataModel]()
    var dataModel = RegistrationDataModel()
    let signUpTVC = SignUpTVC()
    var countryId = Int()
    fileprivate var registrationServiceManager = RegistrationServiceManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAttributeStrCondition()
        getRegistrationDropDown()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myPickerView.delegate = self
        myPickerView.dataSource = self
        tf_state.inputView = myPickerView
        tf_reference.inputView = myPickerView
        tf_country.inputView = myPickerView
        tf_gender.inputView = myPickerView
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

          guard let userInfo = notification.userInfo else { return }
          var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
          keyboardFrame = self.view.convert(keyboardFrame, from: nil)

          var contentInset:UIEdgeInsets = self.scrollView.contentInset
          contentInset.bottom = keyboardFrame.size.height + 20
          scrollView.contentInset = contentInset
      }

      @objc func keyboardWillHide(notification:NSNotification) {

          let contentInset:UIEdgeInsets = UIEdgeInsets.zero
          scrollView.contentInset = contentInset
      }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func getRegistrationDropDown(){
        registrationServiceManager.getDropDownApi { (dropDowns, error) in
            if error != nil{
                
            } else {
                self.heard_fromValues = dropDowns?.heardFromDropDownModel ?? []
                self.countryValues = dropDowns?.countryDropDownModel ?? []
                self.user_typeValues = dropDowns?.userTypeDropDownModel ?? []
                self.myPickerView.reloadAllComponents()
            }
        }
    }
    
    func getStateList(_ countryId:Int){
        self.stateListDataModel.removeAll()
        registrationServiceManager.getStateListApi(countryId) { (stateList, error) in
            if error != nil{
                
            }else{
                self.stateListDataModel = stateList?.stateListDataModel ?? []
                self.myPickerView.reloadAllComponents()
            }
        }
    }
    
    
    
    func generatingParamForSignUp() -> RegistrationDataModel{
        dataModel.f_name = tf_firstName.text
        dataModel.l_name = tf_lastName.text
        dataModel.address_1 = tf_address1.text
        dataModel.address_2 = tf_address2.text
        dataModel.city = tf_city.text
        dataModel.company = tf_companyName.text
        dataModel.email = tf_email.text
        dataModel.accountManager = tf_email.text
        dataModel.phone = tf_phone.text
        dataModel.website = tf_website.text
        dataModel.zipcode = tf_zipCode.text
        dataModel.country = tf_country.tag
        dataModel.userType = tf_gender.tag
        dataModel.fax = txtFieldFax.text
        dataModel.heard_from = tf_reference.tag
        return dataModel
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        registrationServiceManager.gettingDataFromUI(self.generatingParamForSignUp())
        if validateInput(){
            registrationServiceManager.registrationApiRequest { (response) in
                if response.success == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Success")
                    }
                    
                    self.root(identifier: "LoginVC")
                } else {
                    Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
                }
            }
        }
    }
    
    func validateInput() -> Bool {
        if (dataModel.company?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your company name",title: "Error")
        } else if (dataModel.f_name?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your first name",title: "Error")
        } else if (dataModel.l_name?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your last name",title: "Error")
        } else if (dataModel.isAlreadyRegistered == 1) && (dataModel.accountManager?.isBlank)! {
            Proxy.shared.displayStatusCodeAlert("Please enter your account manager's name",title: "Error")
        } else if (dataModel.address_1?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your address",title: "Error")
        } else if (dataModel.city?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your  city",title: "Error")
        } else if (dataModel.state?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your state",title: "Error")
        } else if (dataModel.zipcode?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your zipcode",title: "Error")
        }else if dataModel.country == 0 {
            Proxy.shared.displayStatusCodeAlert("Please enter your country",title: "Error")
        } else if (dataModel.phone?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter your phone number",title: "Error")
        } else if (dataModel.phone?.count ?? 0<10){
            Proxy.shared.displayStatusCodeAlert("Please enter valid phone number",title: "Error")
        } else if (dataModel.email?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert("Please enter email address",title: "Error")
        } else if !(dataModel.email?.isValidEmail())!{
            Proxy.shared.displayStatusCodeAlert("Please enter valid email address",title: "Error")
        } else if dataModel.userType == 0 {
            Proxy.shared.displayStatusCodeAlert("Please enter user type",title: "Error")
        } else if dataModel.acceptTerms == false {
            Proxy.shared.displayStatusCodeAlert("Please accept terms and conditions",title: "Error")
        } else {
            return true
        }
        return false
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionSelectAlreadyRegistered(_ sender: UIButton) {
        btnRegisterdYes.isSelected = false
        btnRegisteredNo.isSelected = false
        if sender.tag == 1 {
            dataModel.isAlreadyRegistered = 1
            btnRegisterdYes.isSelected = true
            viewForAccountManager.isHidden = false
            cnstHeightForView.constant = 90
        } else {
            dataModel.isAlreadyRegistered = 0
            btnRegisteredNo.isSelected = true
            viewForAccountManager.isHidden = true
            cnstHeightForView.constant = 0
        }
    }
    @IBAction func actionAcceptTerms(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
extension SignUpVC {
    
    //MARK:- Custom methods
    private func createAttributeStrCondition() {
        let attributedString = NSMutableAttributedString(string: "I accept all ", attributes: [
            .font: UIFont.systemFont(ofSize: 17.0),
            .foregroundColor: UIColor.lightGray
        ])
        let attributedStringOne = NSMutableAttributedString(string: "terms & conditions", attributes: [
            .font: UIFont.systemFont(ofSize: 17.0),
            .foregroundColor: UIColor.black
            ,.underlineStyle: NSUnderlineStyle.single.rawValue])
        attributedString.append(attributedStringOne)
        lblAcceptTerms.attributedText = attributedString
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.numberOfTapsRequired = 1
        lblAcceptTerms.isUserInteractionEnabled = true
        lblAcceptTerms.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let text = (lblAcceptTerms.text!)
        let termsRange = (text as NSString).range(of: "terms & conditions")
        if gestureRecognizer.didTapAttributedTextInLabel(label: lblAcceptTerms, inRange: termsRange) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsWebViewVC") as! AboutUsWebViewVC
            viewController.title = "Terms and Conditions"
            viewController.cameFrom = "SignUp"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension SignUpVC:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case tf_gender:
            myPickerView.tag = 1
            getRegistrationDropDown()
        case tf_reference:
            myPickerView.tag = 2
            getRegistrationDropDown()
        case tf_country:
            myPickerView.tag = 3
            getRegistrationDropDown()
        case tf_state:
            self.myPickerView.tag = 4
            getStateList(tf_country.tag)
        default:
            break
        }
        return true
    }
    
}
extension SignUpVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var noOfRaws = Int()
        if pickerView.tag == 1 {
            noOfRaws = user_typeValues.count
        } else if pickerView.tag == 2 {
            noOfRaws = heard_fromValues.count
        } else if pickerView.tag == 3 {
            noOfRaws = countryValues.count
        }else if pickerView.tag == 4{
            noOfRaws = stateListDataModel.count
        }
        return noOfRaws
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rawTitle = String()
        if pickerView.tag == 1 {
            rawTitle = user_typeValues[row].name
        } else if pickerView.tag == 2 {
            rawTitle = heard_fromValues[row].name
        } else if pickerView.tag == 3 {
            rawTitle = countryValues[row].name
        }else if pickerView.tag == 4{
            rawTitle = stateListDataModel[row].name
        }
        return rawTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            tf_gender.text = user_typeValues[row].name
            tf_gender.tag = user_typeValues[row].id
        } else if pickerView.tag == 2 {
            tf_reference.text = heard_fromValues[row].name
            tf_reference.tag = heard_fromValues[row].id
        } else if pickerView.tag == 3 {
            tf_country.text = countryValues[row].name
            tf_country.tag = countryValues[row].id
            self.getStateList(countryValues[row].id)
        } else if pickerView.tag == 4 {
            tf_state.text = stateListDataModel[row].name
            dataModel.state = stateListDataModel[row].shortname
        }
    }
    
}
