//
//  FilterVC.swift
//  Luban
//
//  Created by King on 10/17/20.
//

import UIKit

protocol SelectedFilter {
    func filterOption(option:String, type:String, filterDict:NSMutableDictionary)
}

var selectedFilter: SelectedFilter?

class FilterVC: UIViewController {
    var objFilterVM = FilterVM()
    //MARK:- Outlets
    @IBOutlet weak var clcViewFilter: UICollectionView!
    @IBOutlet weak var viewForButtons: UIView!
    //MARK:- View Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    @IBAction func actionFilter(_ sender: UIButton) {
        objFilterVM.filterType = "Filter"
        clcViewFilter.reloadData()
    }
    
    @IBAction func actionSort(_ sender: UIButton) {
        objFilterVM.filterType = "Sort"
        clcViewFilter.reloadData()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        pop()
    }
    
    @IBAction func actionApply(_ sender: UIButton) {
        selectedFilter?.filterOption(option: "", type: objFilterVM.filterType, filterDict: objFilterVM.dictForFilter)
        pop()
    }
    
    @IBAction func actionClearAll(_ sender: UIButton) {
        objFilterVM.dictForFilter.removeAllObjects()
        clcViewFilter.reloadData()
    }
    
    
}
