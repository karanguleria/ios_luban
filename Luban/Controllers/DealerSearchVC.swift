//
//  DealerSearchVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 02/06/20.
//

import UIKit
import GoogleMaps

class DealerSearchVC: UIViewController {
     
    //MARK:- Outlets
    @IBOutlet weak var viewForMap: GMSMapView!
    @IBOutlet weak var listTableView: UITableView!{
        didSet{
            listTableView.delegate = self
            listTableView.dataSource = self
        }
    }
    var objDealersVM = DealerSearchVM()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objDealersVM.getDealersList {
            self.listTableView.reloadData()
            self.getMarkerOnMap()
        }
        
        
    }
    //MARK:- Get Marker On Map
            func getMarkerOnMap() {
                viewForMap.clear()
                for i in 0..<objDealersVM.arrDealerModel.count {
                    let detail = objDealersVM.arrDealerModel[i]
                    if detail.latitude != "" && detail.longitude != "" {
                        let viewCoodinate = Proxy.shared.getCoordinateOfMap(latitute: detail.latitude, longitute: detail.longitude)
                        let markerVw = Bundle.main.loadNibNamed("CallView", owner: nil, options: nil)![0] as! CallView
    //                    markerVw.imgVw.sd_setImage(with: URL(string: "/(detail.2)"),placeholderImage: UIImage(named: "placeholderImage"),completed: nil)
                        let marker = GMSMarker()
                        marker.position = viewCoodinate
                        marker.iconView = markerVw
                        marker.userData = detail
                        marker.title = detail.company
                        marker.tracksViewChanges = false
                        marker.map = viewForMap
                        if i == 0 {
                            viewForMap.setRegion(sourceLocation: viewCoodinate, zoomLevel: 10)
                        }
                    }
                }
        }
    //MARK:- Actions
    @IBAction func cartTapped(_ sender: Any) {
         push(identifier: "MyCartVC")
    }
    @IBAction func menuPressed(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
}

