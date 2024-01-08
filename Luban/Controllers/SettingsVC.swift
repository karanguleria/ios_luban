//
//  SettingsVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 28/03/20.
//

import UIKit

class SettingsVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var settingTableView: UITableView!{
        didSet{
            settingTableView.delegate = self
            settingTableView.dataSource = self
        }
    }
    let menuItem = ["Edit Profile","Change Password","Logout"]
    let menuItemImage = [UIImage(named: "profile"),UIImage(named: "password"),UIImage(named: "logout")]
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    @IBAction func menuBtnPressed(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
    
}
extension SettingsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuItem.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTVC", for: indexPath) as! SettingsTVC
        cell.imgView.image = menuItemImage[indexPath.section]
        if Proxy.shared.accessTokenNil() == "" && indexPath.section == 2 {
            cell.lbl_name.text = "Login"
        } else {
            cell.lbl_name.text = menuItem[indexPath.section]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
           push(identifier: "EditProfileVC")
        } else if indexPath.section == 1 {
            guard let changePassVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC else{
                return
            }
            self.navigationController?.pushViewController(changePassVC, animated: true)
        } else {
            if Proxy.shared.accessTokenNil() != ""{
                UserDefaults.standard.setValue(nil, forKey: "accessToken")
                self.root(identifier: "LoginVC")
            } else {
                presentLoginAlert()
            }
        }
    }
}
