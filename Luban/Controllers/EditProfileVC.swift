//
//  EditProfileVC.swift
//  Luban
//
//  Created by King on 12/23/20.
//

import UIKit

class EditProfileVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tf_companyName: UITextField!
    @IBOutlet weak var tf_firstName: UITextField!
    @IBOutlet weak var tf_lastName: UITextField!
    @IBOutlet weak var tf_address1: UITextField!
    @IBOutlet weak var tf_address2: UITextField!
    @IBOutlet weak var tf_city: UITextField!
    @IBOutlet weak var tf_state: UITextField!
    @IBOutlet weak var txtFieldFax: UITextField!
    @IBOutlet weak var tf_zipCode: UITextField!
    @IBOutlet weak var tf_country: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_website: UITextField!
    
    var objEditProfileVM = EditProfileVM()
    var imageViewController = UIImagePickerController()
    
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objEditProfileVM.myPickerView.delegate = self
        objEditProfileVM.myPickerView.dataSource = self
        imageViewController.delegate = self
        tf_state.inputView = objEditProfileVM.myPickerView
        tf_country.inputView = objEditProfileVM.myPickerView
        objEditProfileVM.getRegistrationDropDown()
        let userDetails = UserInfo.shared.member
        tf_firstName.text = userDetails.fName
        tf_lastName.text = userDetails.lName
        tf_companyName.text = userDetails.company
        tf_city.text = userDetails.city
        tf_state.text = userDetails.stateName
        tf_phone.text = userDetails.phone
        tf_email.text = userDetails.email
        tf_country.text = userDetails.countryName
        tf_country.tag = Int(userDetails.country ?? "0")!
        tf_website.text = userDetails.website
        tf_address1.text = userDetails.address1
        tf_address2.text = userDetails.address2
        tf_zipCode.text = userDetails.zipCode
        objEditProfileVM.selState = userDetails.state ?? ""
        profileImage.sd_setImage(with: URL(string: userDetails.avatar ?? ""), placeholderImage: UIImage(named: "dummyImg"))
        
    }
   
    //MARK:- Actions
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "Choose image from...", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [self] (alert) in
            self.imageViewController.sourceType = .camera
            self.present(self.imageViewController, animated: true, completion: nil)
        }
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
            self.imageViewController.sourceType = .savedPhotosAlbum
            self.present(self.imageViewController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(gallery)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionUploadPic(_ sender: UIButton) {
        
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        if validateInput(){
            let paramDict = ["company":tf_companyName.text!,
                             "f_name":tf_firstName.text!,
                             "l_name":tf_lastName.text!,
                             "address_1":tf_address1.text!,
                             "address_2":tf_address2.text!,
                             "city":tf_city.text!,
                             "state":objEditProfileVM.selState,
                             "zipcode":tf_zipCode.text!,
                             "country":"\(tf_country.tag)",
                             "phone":tf_phone.text!,
                             "website":tf_website.text!,
            "fax":txtFieldFax.text!] as [String:String]
            let paramImage = [self.profileImage.image ?? UIImage()]
            WebServices.shared.uploadImgWithParamRequest(urlString: EndPoints.updateProfile, params: paramDict, paramImage: paramImage, showIndicator: true) { (response) in
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
}
extension EditProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.profileImage.image = image
        } else {
        }
        picker.dismiss()
        self.viewWillAppear(true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss()
    }
}
