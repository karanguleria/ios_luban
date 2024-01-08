//
//  DealerDetailVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 02/06/20.
//

import UIKit
import GoogleMaps

class DealerDetailVC: BaseVC {
    //MARK:- Outlets
    @IBOutlet weak var lbl_cartCount: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var dealerDetailView: UIView!
    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var lblDealerName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lbl_city: UILabel!
    @IBOutlet weak var lbl_country: UILabel!
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var lbl_detail: UILabel!
    @IBOutlet weak var lbl_website: UILabel!
    @IBOutlet weak var lbl_fax: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lblDealerDetailTitle: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_zip: UILabel!
    @IBOutlet weak var lbl_state: UILabel!
    
    
    var objDealerDetail = DealerDetailModel()
    var dealerID:Int?
    fileprivate var homeCategoryServiceManager = HomeCategoryServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_cartCount.isHidden = true
        dealerDetailView.shadowRadius = 5
        dealerDetailView.layer.shadowColor = UIColor.lightGray.cgColor
        dealerDetailView.layer.shadowOffset = CGSize(width: 2, height: 2)
        // Do any additional setup after loading the view.
        guard let dealerId = dealerID else {
            return
        }
        getDealerDetail(dealerId)
    }
    
    override func gettingCartNadWishlistBatchCountDetails(_ cartValue: Int) {
        if cartValue != 0{
            self.lbl_cartCount.isHidden = false
           self.lbl_cartCount.text = "\(cartValue)"
        }else{
            self.lbl_cartCount.isHidden = true
        }
        
    }
    
    func getDealerDetail(_ id:Int){
        homeCategoryServiceManager.getDealerDetail(id) { (dealerDetail, error) in
            if error != nil{
                
            }else{
                guard let dataModel = dealerDetail else {
                    return
                }
                self.objDealerDetail = dataModel
                self.setData()
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func menuTapped(_ sender: Any) {
        pop()
    }
    
    @IBAction func cartTapped(_ sender: Any) {
         push(identifier: "MyCartVC")
    }
    @IBAction func actionRequestQuote(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RequestQuoteVC") as? RequestQuoteVC else {
            return
        }
        vc.store_id = "\(self.objDealerDetail.id)"
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionDirections(_ sender: UIButton) {
        guard let latDouble =  Double(objDealerDetail.latitude) else {Proxy.shared.displayStatusCodeAlert("Location is not correct", title: "Error");return }
        guard let longDouble =  Double(objDealerDetail.longitude) else {Proxy.shared.displayStatusCodeAlert("Location is not correct", title: "Error");return }
              if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
        if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                            UIApplication.shared.open(url, options: [:])
                   }} else {
                     //Open in browser
                    if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?api=1&destination=\(latDouble),\(longDouble)&directionsmode=driving") {
                                       UIApplication.shared.open(urlDestination)
                                  }
                        }
    }
    func setData(){
        lblDealerName.text = objDealerDetail.company
        lblAddress.text = "Address: \(objDealerDetail.addressOne) \(objDealerDetail.addressTwo)"
        lbl_city.text = "City: \(objDealerDetail.city)"
        lblOwnerName.text = "Owner: \(objDealerDetail.firstName) \(objDealerDetail.lastName)"
        lbl_email.text = "Email: \(objDealerDetail.accountEmail)"
        lbl_website.text = "Website: \(objDealerDetail.website)"
        lbl_fax.text = "Fax: \(objDealerDetail.fax)"
        lbl_phone.text = "Phone No: \(objDealerDetail.accountPhone)"
        lbl_state.text = "State: \(objDealerDetail.state_name)"
        lbl_country.text = "Country: \(objDealerDetail.country_name)"
        lbl_zip.text = "Zipcode: \(objDealerDetail.zipcode)"
        lblDealerDetailTitle.isHidden = objDealerDetail.about == ""
        lbl_detail.text = objDealerDetail.about
        let viewCoodinate = Proxy.shared.getCoordinateOfMap(latitute: objDealerDetail.latitude, longitute: objDealerDetail.longitude)
        let markerVw = Bundle.main.loadNibNamed("CallView", owner: nil, options: nil)![0] as! CallView
        let marker = GMSMarker()
        mapView.setRegion(sourceLocation: viewCoodinate, zoomLevel: 8)
        marker.position = viewCoodinate
        marker.iconView = markerVw
        marker.title = objDealerDetail.company
        marker.map = mapView
    }
}
