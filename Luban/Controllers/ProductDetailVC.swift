//
//  ProductDetailVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 31/05/20.
//

import UIKit
import LCBannerView
import MessageUI

class ProductDetailVC: BaseVC, UIPopoverPresentationControllerDelegate,MFMailComposeViewControllerDelegate, ItemAddedToCart {
   
    
    //MARK:- Outlets
    @IBOutlet weak var plusBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_infoHeight: NSLayoutConstraint!
    @IBOutlet weak var bookLetBtn: UIButton!
    @IBOutlet weak var bookletBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_staticMsrp: UILabel!
    @IBOutlet weak var subcatViewHieght: NSLayoutConstraint!
    @IBOutlet weak var lbl_cabinateName: UILabel!
    @IBOutlet weak var bannerView: LCBannerView!
    @IBOutlet weak var cartTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_sampleOrder: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var lbl_info: UILabel!
    @IBOutlet weak var lbl_productName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tblViewProductInfo: UITableView!
    @IBOutlet weak var lbl_cartCount: UILabel!
    @IBOutlet weak var cnstHeightForCabinate: NSLayoutConstraint!
    @IBOutlet weak var viewForCabinate: UIView!
    @IBOutlet weak var lblShopByName: UILabel!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!{
        didSet{
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var varientCollectionView: UICollectionView!{
        didSet{
            varientCollectionView.delegate = self
            varientCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var cabinateCollectionView: UICollectionView!{
        didSet{
            cabinateCollectionView.delegate = self
            cabinateCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var addtoCartTableView: UITableView!{
        didSet{
            addtoCartTableView.delegate = self
            addtoCartTableView.dataSource = self
        }
    }
    fileprivate var wishlistServiceManager = WishlistServiceManager()
    var productId:Int?
    fileprivate var productDetailServiceManager = ProductDetailServiceManager()
    fileprivate var cartServiceManager = CartServiceManager()
    var productDetailModel:ProductDetailDataModel?
    var categoryData = ProductCategoryDataModel()
    var sliderDataModel = [String]()
    var cabinateType = String()
    var subCabinateType = String()
    var selectedIndexPath: IndexPath?
    var isUserLoggedIn = false
    var x = 1
    var currentPage = Int()
    var pageCount = Int()
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        addedToCart = self
        self.infoViewHeightConstraint.constant = 0
        self.infoView.isHidden = true
        self.lbl_cartCount.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionViewLayout()
        self.btn_sampleOrder.cornerRadius = self.btn_sampleOrder.frame.height / 2
        getProductDetail()
        checkLoginOrNot()
    }
    
    func checkLoginOrNot(){
        if Proxy.shared.accessTokenNil() != ""{
            self.isUserLoggedIn = true
            self.lbl_staticMsrp.isHidden = false
            
        } else {
            self.isUserLoggedIn = false
            self.lbl_staticMsrp.isHidden = true
        }
        
    }
    
    override func gettingCartNadWishlistBatchCountDetails(_ cartValue: Int) {
        if cartValue != 0{
            self.lbl_cartCount.isHidden = false
            self.lbl_cartCount.text = "\(cartValue)"
        }else{
            self.lbl_cartCount.isHidden = true
        }
        
    }
    
    func getProductDetail(){
        guard let slug = productId else {
            return
        }
        productDetailServiceManager.getProductFromSlug(page:self.currentPage,cabinate_type: cabinateType, sub_cabinate_type: subCabinateType, slug: slug) { (productResponse, error) in
            if error != nil{
                
            } else {
                
                DispatchQueue.main.async {
                    self.currentPage = productResponse?.currentPage ?? 1
                    self.pageCount = productResponse?.total_page ?? 0
                    self.lbl_staticMsrp.text = productResponse?.sale == 0 ? "Your Price" : "Sale Price"
                    self.productDetailModel = productResponse
                    if productResponse?.productSubCabinateTypeDataModel.count != 0{
                        self.subcatViewHieght.constant = 150
                    }else{
                        self.subcatViewHieght.constant = 0
                    }
                    if productResponse?.productCategoryDataModel?.descriptionKeys.count != 0{
                        self.btn_plus.isHidden = false
                        self.plusBtnHeight.constant = 30
                        self.lbl_info.isHidden = false
                        self.lbl_infoHeight.constant = 20
                    }else{
                        self.btn_plus.isHidden = true
                        self.plusBtnHeight.constant = 0
                        if productResponse?.productCategoryDataModel?.description != ""{
                            self.lbl_info.isHidden = false
                            self.lbl_infoHeight.constant = 50
                            self.lbl_info.text = productResponse?.productCategoryDataModel?.description ?? ""
                        }else{
                        self.lbl_info.isHidden = true
                        self.lbl_infoHeight.constant = 0
                        }
                    }
                    if productResponse?.productCategoryDataModel?.specification_booklet == ""{
                        self.bookletBtnHeight.constant = 0
                        self.bookLetBtn.isHidden = true
                    } else {
                        self.bookletBtnHeight.constant = 30
                        self.bookLetBtn.isHidden = false
                    }
                    if productResponse?.sampleOrderDataModel?.id == 0{
                        self.btn_sampleOrder.isHidden = true
                    }else{
                        self.btn_sampleOrder.isHidden = false
                    }
                    self.categoryData = productResponse?.productCategoryDataModel ?? ProductCategoryDataModel()
                    self.sliderDataModel = productResponse?.productCategoryDataModel?.gallery ?? [String]()
                    
                    self.lbl_productName.text = productResponse?.productCategoryDataModel?.name
                    self.lblShopByName.text = "Shop By \(productResponse?.productCategoryDataModel?.name ?? "")"
                    
                    if self.sliderDataModel.count != 0 {
                     //   self.perform(#selector(self.bannerImagesDisplay), with: nil, afterDelay: 0.02)
                        self.pageControl.numberOfPages = self.sliderDataModel.count
                    }
                    self.cartTableViewHeight.constant = CGFloat(65 + ((productsDataModel.count) * 45))
                    if self.productDetailModel?.productCabinateTypeDataModel.count ?? 0 > 0 {
                        self.cnstHeightForCabinate.constant = 190
                        self.viewForCabinate.isHidden = false
                    } else {
                        self.cnstHeightForCabinate.constant = 0
                        self.viewForCabinate.isHidden = true
                    }
                    self.varientCollectionView.reloadData()
                    self.cabinateCollectionView.reloadData()
                    self.bannerCollectionView.reloadData()
                    self.addtoCartTableView.reloadData()
                    self.tblViewProductInfo.reloadData()
                }
            }
        }
        
    }
    func setTimer() {
            let _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(HomeVC.autoScroll), userInfo: nil,
      repeats: true)
        }
    
    @objc func autoScroll() {
            self.pageControl.currentPage = x
        if self.x < sliderDataModel.count {
                let indexPath = IndexPath(item: x, section: 0)
                self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.x = self.x + 1
            } else {
                self.x = 0
                self.bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    
    func setupCollectionViewLayout(){
        let bannerLayout = UICollectionViewFlowLayout()
        bannerLayout.minimumLineSpacing = 0
        bannerLayout.minimumInteritemSpacing = 0
        bannerLayout.scrollDirection = .horizontal
        bannerCollectionView.collectionViewLayout =  bannerLayout
        let typeLayout = UICollectionViewFlowLayout()
        typeLayout.minimumLineSpacing = 0
        typeLayout.minimumInteritemSpacing = 0
        typeLayout.scrollDirection = .horizontal
        varientCollectionView.collectionViewLayout =  typeLayout
        let cabinateLayout = UICollectionViewFlowLayout()
        cabinateLayout.minimumLineSpacing = 8
        cabinateLayout.minimumInteritemSpacing = 8
        cabinateCollectionView.collectionViewLayout =  cabinateLayout
    }
    
    
    
    //MARK:- IBAction(s)
    @IBAction func expendInfoPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btn_plus.setImage(UIImage(named: "minus"), for: .normal)
            self.infoViewHeightConstraint.constant = CGFloat(38 + ((self.productDetailModel?.productCategoryDataModel?.descriptionKeys.count ?? 0) * 46))
            self.infoView.isHidden = false
        } else {
            btn_plus.setImage(UIImage(named: "plus"), for: .normal)
            self.infoViewHeightConstraint.constant = 0
            self.infoView.isHidden = true
        }
    }
    @IBAction func btnLeftArrowAction(_ sender: Any) {
        let collectionBounds = self.varientCollectionView.bounds
        let contentOffset = CGFloat(floor(self.varientCollectionView.contentOffset.x - varientCollectionView.frame.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
        
    }
    
    @IBAction func btnRightArrowAction(_ sender: Any) {
        let collectionBounds = self.varientCollectionView.bounds
        let contentOffset = CGFloat(floor(self.varientCollectionView.contentOffset.x + varientCollectionView.frame.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
        
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.varientCollectionView.contentOffset.y ,width : self.varientCollectionView.frame.width,height : self.varientCollectionView.frame.height)
        self.varientCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    //MARK:- Actions
    @IBAction func shareBtnPressed(_ sender: Any) {
        // text to share
        let text = self.categoryData.link ?? ""
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,.copyToPasteboard,.message,.print,UIActivity.ActivityType.postToTwitter]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func mailBtnPressed(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setMessageBody("Hi, I found this product and thought you might like it \(self.categoryData.link ?? "")", isHTML: false)
            mail.setSubject("Check out the product \(self.categoryData.name ?? "")")
            //mail.setMessageBody(body, isHTML: false)
            present(mail, animated: true)
        } else {
            Proxy.shared.displayStatusCodeAlert("Mail not configured", title: "Alert!")
           
        }
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        pop()
    }
    
    @IBAction func sampleOrderTapped(_ sender: Any) {
        let productId = "\(self.productDetailModel?.sampleOrderDataModel?.id ?? 0)"
        productDetailServiceManager.addProductToCart(product: productId) { (successMessage, error) in
            if error != nil{
                Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
            } else {
                self.getcartCount()
                Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
            }
        }
    }
    @IBAction func cartBtnPressed(_ sender: Any) {
        push(identifier: "MyCartVC")
    }
    
    
    @IBAction func actionDownloadSpecification(_ sender: UIButton) {
        guard let url = URL(string: productDetailModel?.productCategoryDataModel?.specification_booklet! ?? "") else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func itemAdded(status: Bool) {
        self.getcartCount()
    }
}

//MARK:- CollectionView DataSource and Delegates
extension ProductDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == varientCollectionView{
            return self.productDetailModel?.productCabinateTypeDataModel.count ?? 0
        }else if collectionView == bannerCollectionView{
            return sliderDataModel.count
        }else{
            return self.productDetailModel?.productSubCabinateTypeDataModel.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == varientCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductVarientTypeCVC", for: indexPath) as! ProductVarientTypeCVC
            let dictCat = self.productDetailModel?.productCabinateTypeDataModel[indexPath.row]
            cell.lbl_name.text = dictCat?.name
            cell.imgView.sd_setImage(with: URL(string: dictCat?.image! ?? ""), placeholderImage: UIImage(named: "door"))
            return cell
        }else if collectionView == bannerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBannerCVC", for: indexPath) as! ProductBannerCVC
            cell.imgView.sd_setImage(with: URL(string: sliderDataModel[indexPath.item]), placeholderImage: UIImage(named: "door"))
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCabinateCVC", for: indexPath) as! ProductCabinateCVC
            cell.borderColor = .darkGray
            cell.borderWidth = 1
            if self.selectedIndexPath != nil && indexPath == self.selectedIndexPath {
                cell.layer.backgroundColor = UIColor.lightGray.cgColor
            }else {
                cell.layer.backgroundColor = UIColor.white.cgColor
            }
            cell.lbl_name.text = self.productDetailModel?.productSubCabinateTypeDataModel[indexPath.row].name
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == varientCollectionView{
            let width = self.varientCollectionView.frame.width / 3
            let height = self.varientCollectionView.frame.height
            return CGSize(width: width - 8, height: height)
        }else if collectionView == bannerCollectionView{
            return CGSize(width: self.bannerCollectionView.frame.width, height: self.bannerCollectionView.frame.height)
        } else {
            let label = UILabel(frame: CGRect.zero)
            label.text = self.productDetailModel?.productSubCabinateTypeDataModel[indexPath.row].name
            label.font = UIFont(name: "Roboto-Regular", size: 15)
            label.sizeToFit()
            let width = label.frame.width
            return CGSize(width: width + 8, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == varientCollectionView{
            self.cabinateType = "\(self.productDetailModel?.productCabinateTypeDataModel[indexPath.row].id ?? 0)"
            self.subCabinateType = ""
            self.lbl_cabinateName.text = self.productDetailModel?.productCabinateTypeDataModel[indexPath.row].name
            productsDataModel.removeAll()
            self.currentPage = 0
            self.getProductDetail()
            self.selectedIndexPath = nil
        } else if collectionView == cabinateCollectionView {
            let cell = collectionView.cellForItem(at: indexPath)
            
            cell?.layer.backgroundColor = UIColor.lightGray.cgColor
            
            self.selectedIndexPath = indexPath
            
            self.subCabinateType = "\(self.productDetailModel?.productSubCabinateTypeDataModel[indexPath.row].id ?? 0)"
            self.currentPage = 0
            productsDataModel.removeAll()
            self.getProductDetail()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == varientCollectionView{
            
        }else if collectionView == bannerCollectionView{
            
        }else{
            let cell = collectionView.cellForItem(at: indexPath)
            
            cell?.layer.backgroundColor = UIColor.white.cgColor
            
            self.selectedIndexPath = nil
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            self.pageControl.currentPage = indexPath.item
        }else{
            
        }
        
    }
    
}
extension ProductDetailVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewProductInfo{
            return self.productDetailModel?.productCategoryDataModel?.descriptionKeys.count ?? 0
        }else{
            return productsDataModel.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewProductInfo{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTVC", for: indexPath ) as! ProductDescriptionTVC
            cell.lbl_key.text = self.productDetailModel?.productCategoryDataModel?.descriptionKeys[indexPath.row].key
            let prodVal = self.productDetailModel?.productCategoryDataModel?.descriptionKeys[indexPath.row].val
            cell.lbl_val.text = self.productDetailModel?.productCategoryDataModel?.descriptionKeys[indexPath.row].val
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductAddToCartTVC", for: indexPath ) as! ProductAddToCartTVC
            cell.delegate = self
            cell.cartbtn.tag = indexPath.row
            cell.detailBtn.tag = indexPath.row
            cell.wishlistBtn.tag = indexPath.row
            let product = productsDataModel[indexPath.row]
            cell.lbl_itemNo.text = product.name
            cell.lbl_descrition.text = product.description
            if isUserLoggedIn == true{
                cell.lbl_msrp.textColor = self.productDetailModel?.sale == 0 ? UIColor.black : UIColor.red
                cell.lbl_msrp.text = self.productDetailModel?.sale == 0 ? "$\(product.price ?? "0")" : "$\(product.salePrice ?? "0")"
                cell.lbl_msrp.isHidden = false
            } else {
                cell.lbl_msrp.isHidden = true
            }
            cell.cartbtn.isSelected = product.inCart == 0 ? false : true
            cell.wishlistBtn.isSelected = product.inWishlist == 0 ? false : true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let arrNotifications = productsDataModel
        if indexPath.row == arrNotifications.count - 1 {
            if self.currentPage + 1 <= self.pageCount {
                self.currentPage = self.currentPage + 1
                self.getProductDetail()
            }
        }
    }
}


extension ProductDetailVC:ProductAddToCartTVCDelegate{
    func addToWishlist(_ sender: UIButton) {
        let productId = "\(productsDataModel[sender.tag].id ?? 0)"
        if !sender.isSelected {
            productDetailServiceManager.addProductToWishlist(product: productId) { (successMessage, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    productsDataModel[sender.tag].inWishlist = 1
//                    self.getProductDetail()
                    Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
                }
            }
        } else {
            let productRowId = productsDataModel[sender.tag].in_wishlist_rowId ?? ""
            wishlistServiceManager.removeFromwishlist(productRowId) { (response, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    productsDataModel[sender.tag].inWishlist = 0
//                    self.getProductDetail()
                    Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                }
            }
        }
        addtoCartTableView.reloadData()
    }
    
    func showDetails(_ sender: UIButton) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "ProductPopoverVC") as? ProductPopoverVC else { return }
        popVC.productsDataModel = productsDataModel[sender.tag]
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = sender
        popOverVC?.permittedArrowDirections = .any
        popOverVC?.sourceRect = sender.bounds
        popVC.preferredContentSize = CGSize(width: 315, height: 400)
        self.present(popVC, animated: true)
    }
    
    func addtoCart(_ sender: UIButton) {
        let productId = "\(productsDataModel[sender.tag].id ?? 0)"
        if !sender.isSelected {
            productDetailServiceManager.addProductToCart(product: productId) { (successMessage, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    self.getcartCount()
                    productsDataModel[sender.tag].inCart = 1
//                   self.getProductDetail()
                    Proxy.shared.displayStatusCodeAlert(successMessage ?? "", title: "Success")
                }
            }
        } else {
            let rowID = productsDataModel[sender.tag].in_cart_rowId ?? ""
            cartServiceManager.deleteCartRequest(id: rowID) { (response, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    productsDataModel[sender.tag].inCart = 0
                    Proxy.shared.displayStatusCodeAlert(response ?? "", title: "Success")
                    self.viewWillAppear(true)
                }
            }
        }
        addtoCartTableView.reloadData()
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController,traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
