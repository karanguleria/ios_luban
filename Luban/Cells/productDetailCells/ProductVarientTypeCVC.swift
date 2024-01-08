//
//  ProductVarientTypeCVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 31/05/20.
//

import UIKit

class ProductVarientTypeCVC: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.borderWidth = 1
        self.imgView.borderColor = .lightGray
    }
    
}
