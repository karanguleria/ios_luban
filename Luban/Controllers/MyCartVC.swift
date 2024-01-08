//
//  MyCartVC.swift
//  Luban
//
//  Created by King on 5/31/20.
//

import UIKit
import SwiftyJSON
class MyCartVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblViewCart: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var viewForCartTotal: UIView!
    @IBOutlet weak var viewForGuest: UIView!
    @IBOutlet weak var lbl_priceDetail: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var lbl_salesTax: UILabel!
    @IBOutlet weak var lbl_subTotal: UILabel!
    @IBOutlet weak var lbl_discount: UILabel!
    @IBOutlet weak var lblDiscountTitle: UILabel!
    @IBOutlet weak var txtFldCoupon: UITextField!
    @IBOutlet weak var lblTaxTitle: UILabel!
    @IBOutlet weak var btnForCoupon: UIButton!
    @IBOutlet weak var btnLoginToSee: UIButton!
    @IBOutlet weak var btnClearCart: UIButton!
    @IBOutlet weak var txtFldCartName: UITextField!
    fileprivate var cartServiceManager = CartServiceManager()
    var cartDataModel = CartDataModel()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartData()
    }
    
    func getCartData(){
        cartServiceManager.getCart { (cartResponse, error) in
            if error != nil{
                
            } else {
                guard let cartData = cartResponse else {
                    return
                }
                self.cartDataModel = cartData
                
                self.btnClearCart.isHidden = self.cartDataModel.cartItemsDataModel.count == 0
                self.tblViewCart.reloadData()
                self.lbl_subTotal.text = "\(cartData.subtotal ?? "0")"
                if cartData.discount != "0.00" {
                    self.lbl_discount.isHidden = false
                    self.lblDiscountTitle.isHidden = false
                    self.lbl_discount.text = "\(cartData.discount ?? "0")"
                    self.lblDiscountTitle.text = "Discount"
                } else {
                    self.lbl_discount.isHidden = true
                    self.lblDiscountTitle.isHidden = true
                    self.lbl_discount.text = ""
                    self.lblDiscountTitle.text = ""
                }
                if cartData.couponCode != "" {
                    self.txtFldCoupon.text = cartData.couponCode
                    self.txtFldCoupon.borderWidth = 0
                    self.txtFldCoupon.borderStyle = .none
                    self.txtFldCoupon.isUserInteractionEnabled = false
                    self.btnForCoupon.setTitle("Remove Coupon", for: .normal)
                } else {
                    self.txtFldCoupon.text = ""
                    self.txtFldCoupon.borderWidth = 1
                    self.txtFldCoupon.borderStyle = .roundedRect
                    self.txtFldCoupon.isUserInteractionEnabled = true
                    self.btnForCoupon.setTitle("Apply Coupon", for: .normal)
                }
               
                self.lblTaxTitle.text = cartData.taxRate != "" ? "Tax (\(cartData.taxRate!))" : "Tax"
                self.lbl_salesTax.text = cartData.tax
                let roundedTotal =  cartData.total
                self.totalPrice.text = "\(roundedTotal ?? "")"
                self.lbl_priceDetail.text = "Price Details (\(cartData.itemCount ?? cartData.cartItemsDataModel.count ) Items)"
                self.viewForGuest.isHidden = Proxy.shared.accessTokenNil() != ""
                if self.cartDataModel.cartItemsDataModel.count == 0 && Proxy.shared.accessTokenNil() == "" {
                    self.viewForCartTotal.isHidden = true
                    self.viewForGuest.isHidden = false
                    self.btnLoginToSee.setTitle("Your Cart is Empty", for: .normal)
                } else if self.cartDataModel.cartItemsDataModel.count == 0 && Proxy.shared.accessTokenNil() != "" {
                    self.viewForCartTotal.isHidden = true
                    self.viewForGuest.isHidden = false
                    self.btnLoginToSee.setTitle("Your Cart is Empty", for: .normal)
                } else if self.cartDataModel.cartItemsDataModel.count > 0 && Proxy.shared.accessTokenNil() != "" {
                    self.viewForCartTotal.isHidden = false
                    self.viewForGuest.isHidden = true
                } else {
                    self.viewForCartTotal.isHidden = true
                    self.viewForGuest.isHidden = false
                    self.btnLoginToSee.setTitle("Login in to see price detail.", for: .normal)
                }
            }
        }
    }
    
    func deleteItemFromCart(rowID:String){
        cartServiceManager.deleteCartRequest(id: rowID) { (response, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            } else {
                Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                self.viewWillAppear(true)
            }
        }
    }
    
    func updateQtyOfItem(rowId:String,quantity:String){
        cartServiceManager.updateCartRequest(id: rowId, qty: quantity) { (response, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            } else {
                Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                self.viewWillAppear(true)
            }
        }
    }
    
    
    //MARK:- Actions
    @IBAction func submitBtnTapped(_ sender: Any) {
        guard let checkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as? CheckOutVC else {
            return
        }
        checkoutVC.cartDataModel = self.cartDataModel
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    @IBAction func actionClearCart(_ sender: UIButton) {
        cartServiceManager.clearCartApi { (msg) in
            Proxy.shared.displayStatusCodeAlert(msg, title: "Success")
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func actionOpenMenu(_ sender: UIButton) {
        pop()
    }
    
    @IBAction func actionSaveCart(_ sender: UIButton) {
        if txtFldCartName.text!.isBlank{
            Proxy.shared.displayStatusCodeAlert("Enter any name for your cart", title: "Error")
        } else {
            let param = ["cart_name":txtFldCartName.text!]
            WebServices.shared.postDataRequest(urlString: EndPoints.saveUserCart, params: param, showIndicator: true) { (response) in
                DispatchQueue.main.async {
                    if response.success{
                        self.viewWillAppear(true)
                    } else {
                        Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
                    }
                }
            }
        }
    }
    @IBAction func actionApplyCoupon(_ sender: UIButton) {
        if sender.title(for: .normal) == "Apply Coupon" {
        if txtFldCoupon.text!.isBlank{
            Proxy.shared.displayStatusCodeAlert("Enter coupon code for discount", title: "Error")
        } else {
            let param = ["coupon_code":txtFldCoupon.text!]
            WebServices.shared.postDataRequest(urlString: EndPoints.apply_coupon, params: param, showIndicator: true) { (response) in
                DispatchQueue.main.async {
                    if response.success{
                        self.getCartData()
                    } else {
                        Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
                    }
                }
            }
        }
        } else {
            WebServices.shared.deleteDataRequest(urlString: EndPoints.apply_coupon, showIndicator: true) { (response) in
                DispatchQueue.main.async {
                    if response.success{
                        self.getCartData()
                    } else {
                        Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Error")
                    }
                }
            }
            
        }
    
    }
}

extension MyCartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartDataModel.cartItemsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTVC") as! MyCartTVC
        let cartItem = self.cartDataModel.cartItemsDataModel[indexPath.row]
        cell.gettingUpdateUI(cartItem)
        cell.btnRemoveItem.tag = indexPath.row
        cell.btnMoveToWishlist.tag = indexPath.row
        cell.btnRemoveItem.addTarget(self, action: #selector(removeItemFromCart(_:)), for: .touchUpInside)
        cell.btnMoveToWishlist.addTarget(self, action: #selector(itemMoveToWishlist(_:)), for: .touchUpInside)
        cell.delegate = self
        return cell
    }
    
    @objc func itemMoveToWishlist(_ sender:UIButton){
        self.cartServiceManager.moveItemToWishlist(self.cartDataModel.cartItemsDataModel[sender.tag].rowId ?? "") { [self] (response, error) in
                if error != nil {
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                    self.getCartData()
                    self.viewWillAppear(true)
                }
            }
      
             
        }
    @objc func removeItemFromCart(_ sender:UIButton){
         self.deleteItemFromCart(rowID: self.cartDataModel.cartItemsDataModel[sender.tag].rowId ?? "")
        getCartData()
       }
}
extension MyCartVC:MyCartTVCDelegate{
    func updateQty(id: String, qty: Int) {
        self.updateQtyOfItem(rowId: id, quantity: "\(qty)")
    }
}
