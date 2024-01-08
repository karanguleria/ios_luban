//
//  ProductAddToCartTVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 31/05/20.
//

import UIKit

protocol ProductAddToCartTVCDelegate:class {
    func addtoCart(_ sender:UIButton)
    func showDetails(_ sender:UIButton)
    func addToWishlist(_ sender:UIButton)
}

class ProductAddToCartTVC: UITableViewCell {

    @IBOutlet weak var cartbtn: UIButton!
    @IBOutlet weak var lbl_msrp: UILabel!
    @IBOutlet weak var lbl_itemNo: UILabel!
    @IBOutlet weak var lbl_descrition: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    
    weak var delegate:ProductAddToCartTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cartbtn.cornerRadius = self.cartbtn.frame.height / 2
        self.cartbtn.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func addToCartTapped(_ sender: UIButton) {
        delegate?.addtoCart(sender)
    }
    
    @IBAction func addToWishlist(_ sender: UIButton) {
        delegate?.addToWishlist(sender)
    }
    @IBAction func showDetail(_ sender: UIButton) {
        delegate?.showDetails(sender)
    }
}
