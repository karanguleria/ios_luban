//
//  HomeVC.swift
//  Luban
//
//  Created by King on 3/31/20.
//

import UIKit

class HomeVC: BaseVC {
    //MARK:- Outlets
    @IBOutlet weak var bannerSuperView: UIView!
    @IBOutlet weak var lbl_bannerTitle: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var clcViewForCategories: UICollectionView!
    @IBOutlet weak var cnstHeightForClc: NSLayoutConstraint!
    fileprivate var homeCategoryServiceManager = HomeCategoryServiceManager()
    @IBOutlet weak var lblSuperView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    var HomeCategoryModel = HomeCategoryDataModel()
    var sliderDataModel = [SliderDataModel]()
    let singleton = UserInfo.shared
    var objHome = HomeVM()
    
    @IBOutlet weak var lbl_cartCount: UILabel!
    var x = 1
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clcViewForCategories.register(UINib(nibName: "HomeCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCVC")
        getHomeCategory()
        setTimer()
        pageControl.hidesForSinglePage = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        clcViewForCategories.collectionViewLayout =  layout
        DispatchQueue.main.async {
            self.clcViewForCategories.reloadData()
            self.cnstHeightForClc.constant = self.clcViewForCategories.collectionViewLayout.collectionViewContentSize.height
        }
     
    }
    
    func setTimer() {
            let _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(HomeVC.autoScroll), userInfo: nil,
      repeats: true)
        }
    
    @objc func autoScroll() {
            self.pageControl.currentPage = x
        if self.x < self.HomeCategoryModel.sliderDataModel.count {
                let indexPath = IndexPath(item: x, section: 0)
                self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.x = self.x + 1
            } else {
                self.x = 0
                self.bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    
    
    func getHomeCategory(){
        homeCategoryServiceManager.getHomeCategory { (homeCat, error) in
            if error != nil{
                
            }else{
                self.HomeCategoryModel = homeCat!
                self.sliderDataModel = homeCat?.sliderDataModel ?? []
                if self.sliderDataModel.count != 0 {
                   // self.perform(#selector(self.bannerImagesDisplay), with: nil, afterDelay: 0.02)
                    self.pageControl.numberOfPages = self.sliderDataModel.count
                    self.lbl_bannerTitle.text = self.sliderDataModel[0].title
                }
                DispatchQueue.main.async {
                    self.bannerCollectionView.reloadData()
                }
                self.viewWillAppear(true)
            }
        }
    }
    
    override func gettingCartNadWishlistBatchCountDetails(_ cartValue: Int) {
        if cartValue != 0 {
            self.lbl_cartCount.isHidden = false
            self.lbl_cartCount.text = "\(cartValue)"
        } else {
            self.lbl_cartCount.isHidden = true
        }
        
    }
    
    //MARK:- Actions
    @IBAction func actionMyCart(_ sender: UIButton) {
        push(identifier: "MyCartVC")
    }
    @IBAction func MenuBtnPress(_ sender: Any) {
      KAppDelegate.sideMenuVC.openLeft()
    }
}

