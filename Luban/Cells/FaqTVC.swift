//
//  FaqTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 04/04/20.
//

import UIKit

class FaqTVC: UITableViewCell {

    @IBOutlet weak var lbl_des: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lbl_des.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            if #available(iOS 13.0, *) {
                addBtn.setImage(UIImage.init(systemName: "minus.circle"), for: .normal)
                self.lbl_des.isHidden = false
            } else {
                // Fallback on earlier versions
            }
        }else{
            if #available(iOS 13.0, *) {
                addBtn.setImage(UIImage.init(systemName: "plus.circle"), for: .normal)
                self.lbl_des.isHidden = true
            } else {
                // Fallback on earlier versions
            }
        }
        // Configure the view for the selected state
    }

}
