import UIKit

class CategoriesListVC: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
           // categoryCollectionView.isPagingEnabled = true
        }
    }
    @IBOutlet weak var subCategoryTableView: UITableView!{
        didSet{
            subCategoryTableView.delegate = self
            subCategoryTableView.dataSource = self
        }
    }
    var horizontalLayoutLeftConstraints:NSLayoutConstraint?
    let titleLabelsArray = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7"]
    
  //  let collItems = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7"]
    let tableItems = ["Item T 1","Item T 2","Item T 3","Item T 4","Item T 5","Item T 6","Item T 7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setUpHorizontalBar()
        self.categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [.centeredHorizontally])
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 2
//        layout.minimumInteritemSpacing = 2
//        layout.scrollDirection = .horizontal
//        categoryCollectionView.collectionViewLayout =  layout
       // collectionViewHeight.constant = 4 * 200
        // Do any additional setup after loading the view.
    }
    
    func setUpHorizontalBar() {
       let horizontalSetUpView = UIView()
        horizontalSetUpView.backgroundColor = UIColor.init(red: 101/255, green: 183/255, blue: 239/255, alpha: 1)
       horizontalSetUpView.translatesAutoresizingMaskIntoConstraints = false
       self.view.addSubview(horizontalSetUpView)
       horizontalSetUpView.frame = CGRect(x: 40, y: 44, width: 44, height: 4)
       // Adding constraints to the view
       horizontalLayoutLeftConstraints = horizontalSetUpView.leftAnchor.constraint(equalTo: self.categoryCollectionView.leftAnchor)
       horizontalLayoutLeftConstraints?.isActive = true
       //    horizontalSetUpView.bottomAnchor.constraint(equalTo: self.ordersTitleCollectionView.bottomAnchor).isActive = true
       horizontalSetUpView.bottomAnchor.constraint(equalTo: self.categoryCollectionView.bottomAnchor, constant: 0).isActive = true
       horizontalSetUpView.widthAnchor.constraint(equalTo: self.categoryCollectionView.widthAnchor, multiplier: 1/3).isActive = true
       horizontalSetUpView.heightAnchor.constraint(equalToConstant: 2).isActive = true
       
     }
    func scrollToMenuIndex(_ menuIndex:Int) {
      let indexPath = NSIndexPath(item: menuIndex, section: 0    )
    }
    

    @IBAction func menuTapped(_ sender: Any) {
    }
    
}
extension CategoriesListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleLabelsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
        cell.lbl_name.text = titleLabelsArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.categoryCollectionView.frame.width / 3
        return CGSize(width: width, height: 40)
    }
    
    //MARK::- ScrollView Delegate Method(s)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

extension CategoriesListVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryListTVC", for: indexPath) as! SubCategoryListTVC
        return cell
    }
}
