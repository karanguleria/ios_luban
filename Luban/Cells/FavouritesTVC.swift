//
//  FavouritesTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 30/03/20.
//

import UIKit

class FavouritesTVC: UITableViewCell {

    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
