//
//  MyOrderDataModel.swift
//  Luban
//
//  Created by MAC on 30/08/20.
//

import SwiftyJSON

class MyorderDataModel{
    
    var orderListDataModel = [OrderListDataModel]()
    var singelOrder:OrderListDataModel?
    
    
    func parseMyOrderData(_ json:JSON) -> MyorderDataModel{
        let dataModel = MyorderDataModel()
        
        dataModel.singelOrder = OrderListDataModel().parseOrderListData(json)
        
        let orderArray = json["order"].arrayValue
        for item in orderArray{
            let order = OrderListDataModel().parseOrderListData(item)
            dataModel.orderListDataModel.append(order)
        }
        return dataModel
    }
    
}
class OrderListDataModel{
    var id:Int?
    var user_id:Int?
    var billing_email:String?
    var billing_name:String?
    var billing_address:String?
    var billing_city:String?
    var billing_province:String?
    var billing_postalcode:String?
    var billing_phone:String?
    var billing_discount:String?
    var billing_discount_code:String?
    var billing_subtotal:String?
    var billing_tax:String?
    var billing_total:String?
    var deliverCost:String?
    var date:String?
    var productsDataModel = [ProductsDataModel]()
    
    func parseOrderListData(_ json:JSON) -> OrderListDataModel{
        let dataModel = OrderListDataModel()
        dataModel.id = json["id"].intValue
        dataModel.user_id = json["user_id"].intValue
        dataModel.billing_email = json["billing_email"].stringValue
        dataModel.billing_name = json["billing_name"].stringValue
        dataModel.billing_address = json["billing_address"].stringValue
        dataModel.billing_city = json["billing_city"].stringValue
        dataModel.billing_province = json["billing_province"].stringValue
        dataModel.billing_postalcode = json["billing_postalcode"].stringValue
        dataModel.billing_phone = json["billing_phone"].stringValue
        dataModel.billing_discount = json["billing_discount"].stringValue
        dataModel.billing_discount_code = json["billing_discount_code"].stringValue
        dataModel.billing_subtotal = json["billing_subtotal"].stringValue
        dataModel.billing_tax = json["billing_tax"].stringValue
        dataModel.billing_total = json["billing_total"].stringValue
        dataModel.deliverCost = json["delivery_cost"].stringValue
        dataModel.date = json["date"].stringValue
        
        let productArray = json["products"].arrayValue
        for item in productArray{
            let product = ProductsDataModel().parseOrderProductData(item)
            dataModel.productsDataModel.append(product)
        }
        
        return dataModel
    }
}
