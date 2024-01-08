//
//  FAQViewModel.swift
//  Luban
//
//  Created by MAC on 22/08/20.
//

import UIKit

class FAQViewModel: NSObject {
    var arrNewModel = [FAQDataModel]()
    var selectedCell = -1
    func getNewsList(completion:@escaping() -> Void){
        WebServices.shared.getDataRequest(urlString: EndPoints.faq, showIndicator: true) { (response) in
            if let arrNews = response.data["data"] as? NSArray {
                for dictNews in arrNews {
                    let objNewsModel = FAQDataModel()
                    objNewsModel.getNewsDict(dictData: dictNews as! NSDictionary)
                    self.arrNewModel.append(objNewsModel)
                }
            }
            completion()
        }
    }
}
extension FaqVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return objFaqVM.arrNewModel.count
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAnnoucementTVC", for: indexPath) as! NewsAnnoucementTVC
        let dictNews = objFaqVM.arrNewModel[indexPath.section]
        cell.lbl_title.text = dictNews.title
        
        if objFaqVM.selectedCell == indexPath.section{
            cell.lbl_detail.text = dictNews.description.htmlToString
            cell.btnReadMore.setImage(UIImage(named: "minus"), for: .normal)
        } else {
            cell.lbl_detail.text = ""
            cell.btnReadMore.setImage(UIImage(named: "plus"), for: .normal)
        }
        cell.btnReadMore.tag = indexPath.section
        cell.btnReadMore.addTarget(self, action: #selector(actionReadMore(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objFaqVM.selectedCell = indexPath.section
        faqTableView.reloadData()
    }
    
    @objc func actionReadMore(_ sender:UIButton){
        objFaqVM.selectedCell = sender.tag
        faqTableView.reloadData()
    }
}
