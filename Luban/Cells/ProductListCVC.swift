//
//  ProduCtListCVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 13/05/20.
//

import UIKit

protocol ProductListCVCDelegate:class{
    func compareProduct(_ sender:UIButton)
}

class ProductListCVC: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var imgViewSale: UIImageView!
    @IBOutlet weak var compareView: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var product_imageView: UIImageView!
    @IBOutlet weak var compareBtn: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tblViewDescription: UITableView!
    
    
    weak var delegate:ProductListCVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    @IBAction func compareTapped(_ sender: UIButton) {
        delegate?.compareProduct(sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
        return cell
    }
}

