//
//  MySavedCartVM.swift
//  Luban
//
//  Created by King on 2/2/22.
//

import UIKit

class MySavedCartVM: NSObject {
    var arrSavedCart = [MyorderDataModel]()
    func getOurTeam(completionHandler:@escaping(_ error:String?)->()){
        WebServices.shared.getDataRequest(urlString: EndPoints.ourTeam, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                self.arrSavedCart.removeAll()
                if response.success {
                    if let arrayData = response.data["data"] as? NSArray {
                        for i in 0..<arrayData.count {
//                            if let dictData = arrayData[i] as? NSDictionary {
//                            let product = OurTeamModel().parseOurTeamData(JSON(dictData))
//                                self.arrOurTeam.append(product)
//                            }
                        }
                    } else {
//                    let product = OurTeamModel().parseOurTeamData(JSON(response.data["data"]!))
//                    self.arrOurTeam.append(product)
                    }
                    completionHandler(nil)
                } else {
                    completionHandler(response.message)
                }
            }
        }
    }

}
extension MySavedCartVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCartTVC") as! SavedCartTVC
//        let dictTeam = objOurTeam.arrOurTeam[indexPath.row]
//        cell.lblName.text = dictTeam.name
//        cell.lblDesignation.text = dictTeam.designation
//        cell.lblDescription.text = dictTeam.details
//        cell.imgViewProfile.sd_setImage(with: URL(string: dictTeam.image ?? ""), placeholderImage: UIImage(named: "dummyImg"))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(identifier: "SaveCartDetailVC")
    }
}
