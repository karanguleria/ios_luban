//
//  NewsAnnouncmentVM.swift
//  Luban
//
//  Created by King on 8/16/20.
//

import UIKit

class NewsAnnouncmentVM: NSObject {
    var arrNewModel = [NewsModel]()
    var selectedCell = -1
    func getNewsList(completion:@escaping() -> Void){
        WebServices.shared.getDataRequest(urlString: EndPoints.newsBlogs, showIndicator: true) { (response) in
            if let arrNews = response.data["data"] as? NSArray {
                for dictNews in arrNews {
                    let objNewsModel = NewsModel()
                    objNewsModel.getNewsDict(dictData: dictNews as! NSDictionary)
                    self.arrNewModel.append(objNewsModel)
                }
            }
            completion()
        }
    }
}
extension NewsAnnouncmentVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objNewsBlogsVM.arrNewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAnnoucementTVC", for: indexPath) as! NewsAnnoucementTVC
        let dictNews = objNewsBlogsVM.arrNewModel[indexPath.row]
        cell.lbl_title.text = dictNews.title
        cell.lbl_detail.text = dictNews.newsDetail
        cell.imgView.sd_setImage(with: URL(string: dictNews.image), placeholderImage: UIImage(named: "door"))
        if objNewsBlogsVM.selectedCell == indexPath.row{
            cell.lbl_detail.numberOfLines = 0
            cell.btnReadMore.setTitle("<< Read Less", for: .normal)
        } else {
            cell.lbl_detail.numberOfLines = 2
            cell.btnReadMore.setTitle("Read More >>", for: .normal)
        }
        cell.btnReadMore.tag = indexPath.row
        cell.btnReadMore.addTarget(self, action: #selector(actionReadMore(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func actionReadMore(_ sender:UIButton){
        if objNewsBlogsVM.selectedCell == -1 {
        objNewsBlogsVM.selectedCell = sender.tag
        } else {
        objNewsBlogsVM.selectedCell = -1
        }
        newsTableView.reloadData()
    }
}
