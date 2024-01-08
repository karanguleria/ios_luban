//
//  RequestQuoteVM.swift
//  Luban
//
//  Created by King on 12/5/20.
//

import UIKit
import SwiftyJSON

class RequestQuoteVM: NSObject {
    func requestQuoteApi(_ param: [String:Any],completionHandler:@escaping()->()){
        
        let requestUrl = EndPoints.requestQuote
        WebServices.shared.postDataRequest(urlString: requestUrl, params: param, showIndicator: true) { (response) in
            DispatchQueue.main.async {
                if response.success {
                    Proxy.shared.displayStatusCodeAlert(response.message ?? "", title: "Success")
                    completionHandler()
                }
            }
        }
    }
}
