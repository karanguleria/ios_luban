//
/**
*
*@copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
*@author     : Shiv Charan Panjeta < shiv@toxsl.com >
*
* All Rights Reserved.
* Proprietary and confidential :  All information contained herein is, and remains
* the property of ToXSL Technologies Pvt. Ltd. and its partners.
* Unauthorized copying of this file, via any medium is strictly prohibited.
*/

import UIKit

class DrawerVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewDrawer: UITableView!
    //MARK:- Outlets
    fileprivate var userProfileServiceManager = UserProfileServiceManager()
    @IBOutlet weak var lbl_company: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var viewForGuest: UIView!
    @IBOutlet weak var viewForLoggedIn: UIView!
    @IBOutlet weak var cnstHeightForView: NSLayoutConstraint!
    //MARK:- Variables
    let objDrawerVM = DrawerVM()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForLoggedIn.isHidden = Proxy.shared.accessTokenNil() == ""
        cnstHeightForView.constant = Proxy.shared.accessTokenNil() == "" ? 54 : 100
        tblViewDrawer.isScrollEnabled = true
        if Proxy.shared.accessTokenNil() != ""{
            getUserProfile()
            objDrawerVM.arrDrawer.append(("Logout","LoginVC"))
            profileImgView.isHidden = false
        } else {
            objDrawerVM.arrDrawer.remove(at: 2)
            objDrawerVM.arrDrawer.append(("Login","LoginVC"))
            profileImgView.isHidden = true
        }
        tblViewDrawer.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func getUserProfile(){
        userProfileServiceManager.getUserProfile { (profile, error) in
            if error != nil{
                
            } else {
                self.lbl_name.text = profile?.name?.capitalizingFirstLetter()
                self.lbl_company.text = profile?.company?.capitalizingFirstLetter()
                self.profileImgView.sd_setImage(with: URL(string: profile?.avatar ?? ""), placeholderImage: UIImage(named: "dummyImg"))
            }
        }
}
    
    //MARK:- Actions
    @IBAction func actionMenu(_ sender: UIButton) {
        KAppDelegate.sideMenuVC.closeLeft()
    }
}
          
