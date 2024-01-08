//
//  HomeCategoryVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 25/03/20.
//

import UIKit

class HomeCategoryVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannnerView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    let itemImageArray = [UIImage(named: "door"),UIImage(named: "Cabinet"),UIImage(named: "Countertops"),UIImage(named: "sinks"),UIImage(named: "Faucets"),UIImage(named: "Handles"),UIImage(named: "special-offer")]
    let itemTitleArray = ["Door styles","Cabinate accessories","Countertops","Sinks","Faucets","Handles",""]
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.register(UINib(nibName: "HomeCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCVC")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        categoryCollectionView.collectionViewLayout =  layout
        collectionViewHeight.constant = 4 * 200 
    }
    
    //MARK:- Actions
    @IBAction func MenuBtnPress(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
}
extension HomeCategoryVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitleArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCVC", for: indexPath) as! HomeCategoryCVC
        cell.lbl_name.text = itemTitleArray[indexPath.item]
        cell.imgView.image = itemImageArray[indexPath.item]
        cell.alphaView.isHidden = indexPath.item == 6
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 6{
            let width = self.categoryCollectionView.frame.width / 2
            return CGSize(width: self.categoryCollectionView.frame.width - 8, height: width - 4)
        } else {
            let width = self.categoryCollectionView.frame.width / 2
            return CGSize(width: width - 8, height: width - 4)
        }
        
    }
}
