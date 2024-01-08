//
//  CartDataModel.swift
//  Luban
//
//  Created by MAC on 30/08/20.
//

import Foundation
import SwiftyJSON

class CartDataModel{
    var discount:String?
    var subtotal:String?
    var tax:String?
    var total:String?
    var couponCode:String?
    var taxRate:String?
    var count:Int?
    var itemCount:Int?
    var cartItemsDataModel = [CartItemsDataModel]()
    var wishlistItemsDataModel = [CartItemsDataModel]()
    
    func parseCartData(_ json:JSON) -> CartDataModel{
        let dataModel = CartDataModel()
        dataModel.discount = json["discount"].stringValue
        dataModel.subtotal = json["subtotal"].stringValue
        dataModel.couponCode = json["coupon_code"].stringValue
        dataModel.taxRate = json["tax_rate"].stringValue
        dataModel.tax = json["tax"].stringValue
        dataModel.total = json["total"].stringValue
        
        let itemData = json["cart"].arrayValue
        for item in itemData{
            let cartItem = CartItemsDataModel().parseCartItemData(item)
            dataModel.cartItemsDataModel.append(cartItem)
        }
        let wishlistData = json["wishlist"].arrayValue
        for wishlist in wishlistData{
            let wishlistItem = CartItemsDataModel().parseCartItemData(wishlist)
            dataModel.wishlistItemsDataModel.append(wishlistItem)
        }
        dataModel.count = json["count"].intValue
        dataModel.itemCount = json["count_item"].intValue
        return dataModel
    }
    
}

class CartItemsDataModel{
    var rowId:String?
    var id:Int?
    var qty:Int?
    var name:String?
    var price:String?
    var image:String?
    var description:String?
    var dimention:String?
    var weight:String?
    
    
    func parseCartItemData(_ json:JSON) -> CartItemsDataModel{
        let dataModel = CartItemsDataModel()
        dataModel.rowId = json["rowId"].stringValue
        dataModel.id = json["id"].intValue
        dataModel.qty = json["qty"].intValue
        dataModel.name = json["name"].stringValue
        dataModel.price = json["price"].stringValue
        dataModel.image = json["image"].stringValue
        dataModel.description = json["description"].stringValue
        dataModel.dimention = json["dimention"].stringValue
        dataModel.weight = json["weight"].stringValue
        return dataModel
    }
}
class ShippingCostDataModel{
    
    var success:Bool?
    var message:String?
    var lat_lng:String?
    var alertMsg:String?
    var price:String?
    var total:String?
    
    func parseShippingCostData(_ json:JSON) -> ShippingCostDataModel{
        let dataModel = ShippingCostDataModel()
        dataModel.success = json["success"].boolValue
        dataModel.message = json["message"].stringValue
        let jsonData = json["data"].dictionaryValue
        dataModel.lat_lng = jsonData["lat_lng"]?.stringValue
        dataModel.alertMsg = jsonData["alertMsg"]?.stringValue
        dataModel.price = jsonData["price"]?.stringValue
        dataModel.total = jsonData["total"]?.stringValue
        return dataModel
        
    }
    
}
