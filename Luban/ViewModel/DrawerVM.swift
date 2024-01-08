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

class DrawerVM: NSObject {
    //MARK:- Variables
    var arrDrawer =
        [("Home","TabBarVC"),
//                    ("Find Dealers","DealerSearchVC"),
                    ("Find Dealers","AboutUsWebViewVC"),
                    ("My Orders","OrderHistoryVC"),
                    ("My Saved Cart","MySavedCartVC"),
                    ("Upload And Win","WinAndPrizeVC"),
                    ("News Announcement","NewsAnnouncmentVC"),
                    ("Contact Us","ContactUsVC"),
                    ("FAQ","AboutUsWebViewVC"),
                    ("Warranty","AboutUsWebViewVC"),
                    ("Return Policy","AboutUsWebViewVC"),
                    ("Shipping and Delivery","AboutUsWebViewVC"),
                    ("Terms and Conditions","AboutUsWebViewVC"),
                    ("Privacy Policy","AboutUsWebViewVC")]
    
    var selectedIndex = -1
}

extension DrawerVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objDrawerVM.arrDrawer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerTVC") as! DrawerTVC
        let dict = objDrawerVM.arrDrawer[indexPath.row]
        cell.lblTitle.text = dict.0 as String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objDrawerVM.selectedIndex = indexPath.row
        KAppDelegate.sideMenuVC.closeLeft()
        let dict = objDrawerVM.arrDrawer[indexPath.row]
        switch dict.0 {
        case "Logout", "Login":
             if Proxy.shared.accessTokenNil() != "" {
                Proxy.shared.hitlogoutApi {
                UserDefaults.standard.setValue(nil, forKey: "accessToken")
                self.root(identifier: dict.1)
                }
            } else {
                self.root(identifier: dict.1)
            }

        default:
            rootWithDrawer(identifier: dict.1, titleVal: dict.0)
        }
    }
}
