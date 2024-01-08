//
//  WishlistCVC.swift
//  Luban
//
//  Created by MAC on 27/09/20.
//

import UIKit

protocol WishlistCVCDelegate:class {
    func removeFromWishlist(_ rowId:String)
    func moveToCart(_ rowID:String)
}

class WishlistCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var id:Int?
    var rowId:String?
    weak var delegate:WishlistCVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.borderColor = .lightGray
        self.contentView.borderWidth = 1
    }
    
    func gettingUpdateUI(_ dataModel:CartItemsDataModel){
        self.lbl_name.text = dataModel.name
        self.imgView.sd_setImage(with: URL(string: dataModel.image!), placeholderImage: UIImage(named: "door"))
        self.id = dataModel.id
        self.rowId = dataModel.rowId

    }
    
    @IBAction func removeFromWishlist(_ sender: Any) {
        guard let id = self.rowId else {
            return
        }
        delegate?.removeFromWishlist(id)
    }
    @IBAction func moveToCart(_ sender: Any) {
        guard let id = self.rowId else{
            return
        }
        delegate?.moveToCart(id)
    }
}
