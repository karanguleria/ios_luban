//
//  OurTeamVM.swift
//  Luban
//
//  Created by King on 12/1/20.
//

import UIKit
import SwiftyJSON

class OurTeamVM: NSObject {
    var arrOurTeam = [OurTeamModel]()
    func getOurTeam(completionHandler:@escaping(_ error:String?)->()){
        WebServices.shared.getDataRequest(urlString: EndPoints.ourTeam, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                self.arrOurTeam.removeAll()
                if response.success {
                    if let arrayData = response.data["data"] as? NSArray {
                        for i in 0..<arrayData.count {
                            if let dictData = arrayData[i] as? NSDictionary {
                            let product = OurTeamModel().parseOurTeamData(JSON(dictData))
                                self.arrOurTeam.append(product)
                            }
                        }
                    } else {
                    let product = OurTeamModel().parseOurTeamData(JSON(response.data["data"]!))
                    self.arrOurTeam.append(product)
                    }
                    completionHandler(nil)
                } else {
                    completionHandler(response.message)
                }
            }
        }
    }
}

extension OurTeamVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return objOurTeam.arrOurTeam.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OurTeamTVC") as! OurTeamTVC
        let dictTeam = objOurTeam.arrOurTeam[indexPath.row]
        cell.lblName.text = dictTeam.name
        cell.lblDesignation.text = dictTeam.designation
        cell.lblDescription.text = dictTeam.details
        cell.imgViewProfile.sd_setImage(with: URL(string: dictTeam.image ?? ""), placeholderImage: UIImage(named: "dummyImg"))
        return cell
    }
}
