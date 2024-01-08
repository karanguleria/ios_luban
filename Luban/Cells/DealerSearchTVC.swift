//
//  DealerSearchTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 02/06/20.
//

import UIKit

class DealerSearchTVC: UITableViewCell {
    @IBOutlet weak var lbl_nam: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var lbl_phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBtn.cornerRadius = self.viewBtn.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
