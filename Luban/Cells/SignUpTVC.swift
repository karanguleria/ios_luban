//
//  SignUpTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 24/03/20.
//

import UIKit

class SignUpTVC: UITableViewCell {

    
    //MARK:- Views Outlet(s)
   
    @IBOutlet weak var view_reference: UIView!
    @IBOutlet weak var view_gender: UIView!
    @IBOutlet weak var viewWebsite: UIView!
    @IBOutlet weak var view_mail: UIView!
    @IBOutlet weak var view_phone: UIView!
    @IBOutlet weak var view_country: UIView!
    @IBOutlet weak var view_zipCode: UIView!
    @IBOutlet weak var view_state: UIView!
    @IBOutlet weak var view_city: UIView!
    @IBOutlet weak var view_address2: UIView!
    @IBOutlet weak var view_address1: UIView!
    @IBOutlet weak var view_lname: UIView!
    @IBOutlet weak var view_companyName: UIView!
    @IBOutlet weak var view_fname: UIView!
  
    //MARK:- Button Outlet(s)
  
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var btn_terms: UIButton!
    
    //MARK:- Textfield Outlet(s)

    @IBOutlet weak var tf_companyName: UITextField!
    @IBOutlet weak var tf_firstName: UITextField!
    @IBOutlet weak var tf_lastName: UITextField!
    @IBOutlet weak var tf_address1: UITextField!
    @IBOutlet weak var tf_address2: UITextField!
    @IBOutlet weak var tf_city: UITextField!
    @IBOutlet weak var tf_state: UITextField!
    @IBOutlet weak var tf_zipCode: UITextField!
    @IBOutlet weak var tf_country: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_website: UITextField!
    @IBOutlet weak var tf_gender: UITextField!
    @IBOutlet weak var tf_reference: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.settingBtnAndViews()
        // Initialization code
    }

    func settingBtnAndViews(){
        ViewCustomMethod.setCircleBorder(view_reference)
        ViewCustomMethod.setCircleBorder(view_gender)
        ViewCustomMethod.setCircleBorder(viewWebsite)
        ViewCustomMethod.setCircleBorder(view_mail)
        ViewCustomMethod.setCircleBorder(view_phone)
        ViewCustomMethod.setCircleBorder(view_country)
        ViewCustomMethod.setCircleBorder(view_zipCode)
        ViewCustomMethod.setCircleBorder(view_state)
        ViewCustomMethod.setCircleBorder(view_city)
        ViewCustomMethod.setCircleBorder(view_address2)
        ViewCustomMethod.setCircleBorder(view_address1)
        ViewCustomMethod.setCircleBorder(view_companyName)
        ViewCustomMethod.setCircleBorder(view_fname)
        ViewCustomMethod.setCircleBorder(view_lname)
      //  ViewCustomMethod.setBtnCircleBorder(signUpBtn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnTermsTapped(_ sender: Any) {
  
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
    
    }
    
}
