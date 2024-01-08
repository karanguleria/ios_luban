//
//  AboutUsWebViewVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 04/04/20.
//

import UIKit
import WebKit

enum WebViewType{
    case Warranty
    case Return_Policy
    case Shipping_Delivery
    case Terms_Conditions
    case Privacy_Policy
    case FAQ
}

class AboutUsWebViewVC: UIViewController,WKNavigationDelegate {
    //MARK:- Outlets
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnBack: UIButton!
    
    var cameFrom = String()
    var webViewType = String()
    
    var webUrl :URL?
    
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = false
        self.lbl_title.text = self.title
        btnBack.setImage(UIImage(named: cameFrom == "SignUp" ? "backwhite" : "menu" ), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWebView()
    }
    
    func setWebView(){
        switch self.title {
        case "Privacy Policy":
            self.lbl_title.text = "Privacy Policy"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)privacy-policy")
        case "Return Policy":
            self.lbl_title.text = "Return Policy"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)return-policy")
        case "Shipping and Delivery":
            self.lbl_title.text = "Shipping and Delivery"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)shipping-delivery")
        case "Terms and Conditions":
            self.lbl_title.text = "Terms and Conditions"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)term-&-conditions")
        case "Warranty":
            self.lbl_title.text = "Warranty"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)warranty")
        case "FAQ":
            self.lbl_title.text = "FAQ"
            self.webUrl = URL(string: "\(EndPoints.BASE_URL)faq")
        case "Find Dealers":
            self.lbl_title.text = "Dealer Search"
            self.webUrl = URL(string: "https://www.lubancabinetry.com/stores/store-mobile")
            
        default:break
            
        }
        if let urlRequest = webUrl{
            webView.load(URLRequest(url: urlRequest))
        }
    }
  
    
    //MARK:- Actions
    @IBAction func menuTapped(_ sender: Any) {
        if cameFrom == "SignUp" {
           pop()
        } else {
            KAppDelegate.sideMenuVC.openLeft()
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard case .linkActivated = navigationAction.navigationType,
                  let url = navigationAction.request.url
            else {
                decisionHandler(.allow)
                return
            }
            decisionHandler(.cancel)
            UIApplication.shared.canOpenURL(url)
        
       }
}
