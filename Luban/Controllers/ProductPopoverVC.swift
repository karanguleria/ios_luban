//
//  ProductPopoverVC.swift
//  Luban
//
//  Created by MAC on 13/09/20.
//

import UIKit
protocol ItemAddedToCart{
    func itemAdded(status:Bool)
}
var addedToCart: ItemAddedToCart?
class ProductPopoverVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var mrpStackView: UIStackView!
    @IBOutlet weak var lbl_itemNo: UILabel!
    @IBOutlet weak var lbl_des: UILabel!
    @IBOutlet weak var dimensions: UILabel!
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_msrp: UILabel!
    @IBOutlet weak var lbl_WT: UILabel!
    @IBOutlet weak var lblYourPrice: UILabel!
    @IBOutlet weak var yourPriceView: UIStackView!
    @IBOutlet weak var lblSpecailOfferPrice: UILabel!
    @IBOutlet weak var stkViewOfferPrice: UIStackView!
    @IBOutlet weak var lblOfferPrice: UILabel!
    
    var productsDataModel:ProductsDataModel?
    fileprivate var productDetailServiceManager = ProductDetailServiceManager()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cartBtn.cornerRadius = self.cartBtn.frame.height / 2
        self.cartBtn.clipsToBounds = true
        guard let data = productsDataModel else {
            return
        }
        setData(data)
        self.mrpStackView.isHidden = Proxy.shared.accessTokenNil() == ""
        self.yourPriceView.isHidden = Proxy.shared.accessTokenNil() == ""
        
    }
    
    func setData(_ dataModel:ProductsDataModel){
        self.lbl_itemNo.text = dataModel.name
        self.lbl_des.text = dataModel.description
        self.dimensions.text = dataModel.dimention
        self.lbl_msrp.text = "$\(dataModel.actualPrice ?? "0")"
        self.lblYourPrice.text = "$\(dataModel.price ?? "0")"
        self.stkViewOfferPrice.isHidden = (Proxy.shared.accessTokenNil() == "" || dataModel.salePrice == "0")
        self.lblOfferPrice.text = "$\(dataModel.salePrice ?? "0")"
        self.lbl_WT.text = dataModel.weight
        imgViewProduct.sd_setImage(with: URL(string: dataModel.image!), placeholderImage: UIImage(named: "door"))
    }
    
    //MARK:- Actions
    @IBAction func addtoCartPressed(_ sender: Any) {
        let productId = "\(self.productsDataModel?.id ?? 0)"
        productDetailServiceManager.addProductToCart(product: productId) { (successMessage, error) in
            if error == nil{
                self.getcartCount()
                Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
                addedToCart?.itemAdded(status: true)
                self.dismiss()
            }
        }
    }
}
