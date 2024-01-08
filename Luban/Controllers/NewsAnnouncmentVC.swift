//
//  NewsAnnouncmentVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 02/06/20.
//

import UIKit

class NewsAnnouncmentVC: BaseVC {
    //MARK:- Outlets
    @IBOutlet weak var newsTableView: UITableView!{
        didSet{
            newsTableView.delegate = self
            newsTableView.dataSource = self
        }
    }
    var objNewsBlogsVM = NewsAnnouncmentVM()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objNewsBlogsVM.getNewsList {
            DispatchQueue.main.async {
                 self.newsTableView.reloadData()
            }
        }
    
    }
   
    //MARK:- Actions
    @IBAction func menuPressed(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
    
}

