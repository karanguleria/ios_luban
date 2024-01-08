//
//  FaqVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 04/04/20.
//

import UIKit

class FaqVC: UIViewController {

    @IBOutlet weak var faqTableView: UITableView!
    
    var objFaqVM = FAQViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faqTableView.rowHeight = UITableView.automaticDimension
//        objFaqVM.getNewsList {
//            DispatchQueue.main.async {
//                 self.faqTableView.reloadData()
//            }
//        }
    }
    

    @IBAction func menuPressed(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
    
}
