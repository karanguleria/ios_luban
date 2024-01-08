//
//  ProfileVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 27/03/20.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK:- Outlets
    
    @IBOutlet weak var lbl_customerBusinessInfo: UILabel!
    @IBOutlet weak var lbl_managerName: UILabel!
    @IBOutlet weak var lbl_companyEmail: UILabel!
    @IBOutlet weak var lbl_AccountManagerName: UILabel!
    @IBOutlet weak var lbl_companyPhone: UILabel!
    @IBOutlet weak var lbl_webSite: UILabel!
    @IBOutlet weak var lbl_fax: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_bccEmail: UILabel!
    @IBOutlet weak var lbl_ccEmail: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_company: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var imgBackGrndProfile: UIImageView!
    
    fileprivate var userProfileServiceManager = UserProfileServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Proxy.shared.accessTokenNil() != "" {
            self.getUserProfile()
        }
        self.tabBarController?.tabBar.isHidden = false
    }

    func getUserProfile(){
        userProfileServiceManager.getUserProfile { (profile, error) in
            if error != nil{
                
            } else {
                self.lbl_name.text = "\(profile?.fName?.capitalizingFirstLetter() ?? "") \(profile?.lName?.capitalizingFirstLetter() ?? "")"
                self.lbl_company.text = profile?.company?.capitalizingFirstLetter()
                self.lbl_phone.text = profile?.phone
                self.lbl_companyPhone.text = profile?.accountManagerPhone
                self.lbl_email.text = profile?.email
                self.lbl_fax.text = profile?.fax
                self.lbl_address.text = "\(profile?.address1 ?? "") \(profile?.address2 ?? "") \(profile?.city ?? "") \(profile?.state ?? "") \(profile?.country ?? "")"
                self.lbl_webSite.text = profile?.website
                self.lbl_managerName.text = profile?.accountManager?.capitalizingFirstLetter() ?? "N/A"
                self.lbl_companyEmail.text = profile?.accountManagerEmail ?? "N/A"
                self.lbl_companyPhone.text = profile?.accountManagerPhone ?? "N/A"
                self.lbl_customerBusinessInfo.text = "Reseller Permit Expiration Date: \(profile?.resellerPermitExpirationDate ?? "")"
                self.profileImageView.sd_setImage(with: URL(string: profile?.avatar ?? "") , placeholderImage: UIImage(named:"dummyImg"))
                self.imgBackGrndProfile.sd_setImage(with: URL(string: profile?.avatar ?? "") , placeholderImage: UIImage(named:"dummyImg"))
            }
        }
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
}
