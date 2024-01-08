//
//  CompareProductsTVC.swift
//  Luban
//
//  Created by King on 11/20/20.
//

import UIKit

protocol CompareProductsTVCDelegate:class {
    func viewProduct(sender:UIButton)
}

class CompareProductsTVC: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var btn_viewProduct: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
  
    weak var delegate:CompareProductsTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func viewProductTapped(_ sender: UIButton) {
        delegate?.viewProduct(sender: sender)
    }
    
}
