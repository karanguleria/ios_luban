//
//  ContactUsVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 28/03/20.
//

import UIKit
import GoogleMaps

class ContactUsVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lbl_closingTime: UILabel!
    @IBOutlet weak var lbl_fax: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lblHolidays: UILabel!
    fileprivate var contactUsServiceManager = ContactUsServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getContactUsDetails()
    }
    
    func getContactUsDetails(){
        contactUsServiceManager.getContactUsDetail { (contactModel, error) in
            if error != nil {
                
            } else {
                self.lbl_fax.text = contactModel?.fax
                self.lbl_phone.text = contactModel?.phone
                self.lbl_email.text = contactModel?.email
                self.lbl_address.text = contactModel?.address
                self.lbl_closingTime.text = contactModel?.openingTime
                self.lblHolidays.text = contactModel?.openingTimeWeekends
                let viewCoodinate = Proxy.shared.getCoordinateOfMap(latitute: contactModel?.lat ?? "0", longitute: contactModel?.long ?? "0")
                let markerVw = Bundle.main.loadNibNamed("CallView", owner: nil, options: nil)![0] as! CallView
                let marker = GMSMarker()
                self.mapView.setRegion(sourceLocation: viewCoodinate, zoomLevel: 8)
                marker.position = viewCoodinate
                marker.iconView = markerVw
                marker.title = contactModel?.address
                marker.map = self.mapView
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func menuTapped(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
    
    @IBAction func actionOurTeam(_ sender: UIButton) {
        push(identifier: "OurTeamVC")
    }
    
    @IBAction func actionHelpSupport(_ sender: UIButton) {
        push(identifier: "ContactSupportVC")
    }
}
