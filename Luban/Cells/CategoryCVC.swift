//
//  CategoryCVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 30/03/20.
//

import UIKit

class CategoryCVC: UICollectionViewCell {
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomView.isHidden = true
//        self.contentView.layer.cornerRadius = self.contentView.frame.height / 2
//        self.contentView.borderColor = .lightGray
//        self.contentView.clipsToBounds = true
//        self.contentView.borderWidth = 1
    }
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.bottomView.isHidden = false
//                self.layer.borderWidth = 1.0
//                self.layer.cornerRadius = self.bounds.height / 2
//                self.layer.borderColor = UIColor.purple.cgColor
//                //self.genreNameLabel.textColor = UIColor.purple
            }
            else
            {
                self.bottomView.isHidden = true
//                self.layer.borderWidth = 0.0
//                self.layer.cornerRadius = 0.0
//                //self.genreNameLabel.textColor = UIColor.white
            }
        }
    }
    
}
