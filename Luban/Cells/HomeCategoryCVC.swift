//
//  HomeCategoryCVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 25/03/20.
//

import UIKit

class HomeCategoryCVC: UICollectionViewCell {
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alphaView.layer.cornerRadius = 5
        alphaView.clipsToBounds = true
    }

}
