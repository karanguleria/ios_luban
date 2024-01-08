//
//  OurTeamVC.swift
//  Luban
//
//  Created by King on 12/1/20.
//

import UIKit

class OurTeamVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblViewOurTeam: UITableView!
    var objOurTeam = OurTeamVM()
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objOurTeam.getOurTeam { (error) in
            self.tblViewOurTeam.reloadData()
        }
    }
    
    //MARK:- Actions
    @IBAction func actionBack(_ sender: UIButton) {
        pop()
    }
}
