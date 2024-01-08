//
//  ProductListVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 13/05/20.
//

import UIKit

class ProductListVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblCompareItemCount: UILabel!
    @IBOutlet weak var lbl_cartCount: UILabel!
    @IBOutlet weak var btn_clearAll: UIButton!
    @IBOutlet weak var btn_compare: UIButton!
    @IBOutlet weak var viewForCompare: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productCollectionView: UICollectionView!{
        didSet{
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
        }
    }
    var subcategoryDataModel = [SubCategoryDataModel]()
    var slug:String?
    var paramForCat = [String:AnyObject]()
    var compareItemArray = [SubCategoryDataModel]()
    var sortDataModel = [SortDataModel]()
    var filterDataModel = [FilterDataModel]()
    fileprivate var homeCategoryServiceManager = HomeCategoryServiceManager()
    
    //MARK:- Override Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_cartCount.isHidden = true
        selectedFilter = self
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        productCollectionView.collectionViewLayout = layout
        let comparelayout = UICollectionViewFlowLayout()
        comparelayout.minimumLineSpacing = 8
        comparelayout.minimumInteritemSpacing = 8
        btn_clearAll.layer.cornerRadius = btn_clearAll.frame.height / 2
        btn_clearAll.clipsToBounds = true
        btn_compare.layer.cornerRadius = btn_compare.frame.height / 2
        btn_compare.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let slug = self.slug{
            getSubcategory(slug: slug)
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
    
    func getSubcategory(slug:String){
        self.subcategoryDataModel.removeAll()
        homeCategoryServiceManager.getCategoryFromSlug(slug, param: paramForCat) { (category, error) in
            if error != nil{
                
            }else{
                self.subcategoryDataModel = category?.subcategoryDataModel ?? []
                self.sortDataModel = category?.sortDataModel ?? []
                self.filterDataModel = category?.frameShapeDataModel ?? []
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            }
        }
    }
    
    //MARK:- IBAction(s)
    @IBAction func listTapped(_ sender: Any) {
    }
    @IBAction func filterTapped(_ sender: UIButton) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        nextVC.objFilterVM.filterType = "Filter"
        nextVC.objFilterVM.arrFilter = filterDataModel
        nextVC.objFilterVM.arrSort = sortDataModel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func sortTapped(_ sender: UIButton) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        nextVC.objFilterVM.filterType = "Sort"
        nextVC.objFilterVM.arrFilter = filterDataModel
        nextVC.objFilterVM.arrSort = sortDataModel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
    
    @IBAction func compareTapped(_ sender: Any) {
        let comapareVC = storyboard?.instantiateViewController(withIdentifier: "CompareItemsVC") as! CompareItemsVC
        comapareVC.arrCompareItems = compareItemArray
        self.navigationController?.pushViewController(comapareVC, animated: true)
    }
    
    @IBAction func clearAllTapped(_ sender: Any) {
        self.compareItemArray.removeAll()
        viewForCompare.isHidden = true
    }
    
    @IBAction func cartTapped(_ sender: Any) {
        push(identifier: "MyCartVC")
    }
}
