//
//  ProductDescriptionTVC.swift
//  Luban
//
//  Created by MAC on 02/10/20.
//

import UIKit

class ProductDescriptionTVC: UITableViewCell {
    @IBOutlet weak var lbl_key: UILabel!
    @IBOutlet weak var cnstWidthVal: NSLayoutConstraint!
    @IBOutlet weak var lbl_val: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
