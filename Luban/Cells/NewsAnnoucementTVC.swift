//
//  NewsAnnoucementTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 02/06/20.
//

import UIKit

class NewsAnnoucementTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_detail: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //imgView.borderColor = .lightGray
        //imgView.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
