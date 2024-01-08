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

class SplashVC: UIViewController {
    //MARK:- Variables
    var objSplashVM = SplashVM()
    
    //MARK:- View life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if Proxy.shared.accessTokenNil() == "" {
            self.rootWithDrawer(identifier: "TabBarVC")
        } else {
        objSplashVM.getUserProfile { (userData, error) in
            error == nil ? self.rootWithDrawer(identifier: "TabBarVC") : self.root(identifier: "LoginVC")
        }
        }
}
}
