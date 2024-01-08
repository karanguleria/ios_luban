//
//  FAQDataModel.swift
//  Luban
//
//  Created by MAC on 22/08/20.
//

import Foundation
import SwiftyJSON

class FAQDataModel{
    var title = String(), description = String()
    var id = Int()
    func getNewsDict(dictData:NSDictionary){
        description = dictData["description"] as? String ?? ""
        title = dictData["title"] as? String ?? ""
        id = dictData["id"] as? Int ?? 0
    }
}
