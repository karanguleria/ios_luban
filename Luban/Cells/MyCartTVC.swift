//
//  MyCartTVC.swift
//  Luban
//
//  Created by King on 5/31/20.
//

import UIKit

protocol MyCartTVCDelegate:class {
    func updateQty(id:String,qty:Int)
}

class MyCartTVC: UITableViewCell {

    @IBOutlet weak var lbl_qty: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_productDes: UILabel!
    @IBOutlet weak var lbl_productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var lbl_orderOn: UILabel!
    @IBOutlet weak var lbl_orderNo: UILabel!
    @IBOutlet weak var btnMoveToWishlist: UIButton!
    @IBOutlet weak var btnRemoveItem: UIButton!
    
    
    
    weak var delegate:MyCartTVCDelegate?
    var qty = Int()
    var rowId = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func gettingUpdateUI(_ dataModel:CartItemsDataModel){
        self.lbl_qty.text = "\(dataModel.qty ?? 0)"
        self.qty = dataModel.qty ?? 0
        self.rowId = dataModel.rowId ?? ""
        self.lbl_amount.text = "\(dataModel.price ?? "0")"
        self.lbl_amount.isHidden = Proxy.shared.accessTokenNil() == ""
        self.lbl_productName.text = dataModel.name
        self.lbl_productDes.text = dataModel.description
        self.productImage.sd_setImage(with: URL(string: dataModel.image ?? ""), placeholderImage: UIImage(named: "door"))
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        self.qty += 1
        delegate?.updateQty(id: rowId, qty: self.qty)
    }
    
    @IBAction func minusTapped(_ sender: Any) {
        guard self.qty >= 1 else {
            return
        }
        self.qty -= 1
        delegate?.updateQty(id: rowId, qty: self.qty)
    }
    
}
