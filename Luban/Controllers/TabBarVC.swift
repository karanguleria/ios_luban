//
//  TabBarVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 28/03/20.
//

import UIKit

class TabBarVC: UITabBarController,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
       
        if  let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray {
           if let tabBarItem = arrayOfTabBarItems[1] as? UITabBarItem {
            tabBarItem.isEnabled = Proxy.shared.accessTokenNil() == "" ? false : true
            }
            if let tabBarSetting = arrayOfTabBarItems[3] as? UITabBarItem {
                tabBarSetting.isEnabled = Proxy.shared.accessTokenNil() == "" ? false : true
             }
        }
        
    }
}
