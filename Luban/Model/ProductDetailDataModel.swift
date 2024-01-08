//
//  ProductDetailDataModel.swift
//  Luban
//
//  Created by MAC on 29/08/20.
//

import UIKit
import SwiftyJSON

var productsDataModel = [ProductsDataModel]()

class ProductDetailDataModel{
    var sampleOrderDataModel:SampleOrderDataModel?
    var productCategoryDataModel:ProductCategoryDataModel?
    var productCabinateTypeDataModel = [ProductCabinateTypeDataModel]()
    var productSubCabinateTypeDataModel = [ProductSubCabinateTypeDataModel]()
    
    var currentPage:Int?
    var total_page:Int?
    var sale:Int?
    
    
    func parseDatafromJson(_ json:JSON) -> ProductDetailDataModel{
        let productDetailDataModel = ProductDetailDataModel()
        productDetailDataModel.currentPage = json["current_page"].intValue
        productDetailDataModel.total_page = json["total_page"].intValue
        productDetailDataModel.sale = json["sale"].intValue
        let currentPage = json["current_page"].intValue
            let catData = ProductCategoryDataModel().parseCategoryData(json["category"])
            productDetailDataModel.productCategoryDataModel = catData
            let sampleOrder = SampleOrderDataModel().parseSampleData(json["sampledoor"])
            productDetailDataModel.sampleOrderDataModel = sampleOrder
            let cabinateData = json["cabinateType"].arrayValue
            for cabinateItem in cabinateData{
                let cabinate = ProductCabinateTypeDataModel().parseCabinateTypeData(cabinateItem)
                productDetailDataModel.productCabinateTypeDataModel.append(cabinate)
            }
            let subCabinateData = json["subCabinateType"].arrayValue
            for subCabinateItem in subCabinateData{
                let subCabinate = ProductSubCabinateTypeDataModel().parseSubCabinateTypeData(subCabinateItem)
                productDetailDataModel.productSubCabinateTypeDataModel.append(subCabinate)
            }
            let productsData = json["products"].arrayValue
            if currentPage == 1{
            productsDataModel.removeAll()
            }
            for productItem in productsData{
                let product = ProductsDataModel().parseOrderProductData(productItem)
                productsDataModel.append(product)
            }
//        }else{
//            let productsData = json["products"].arrayValue
//            for productItem in productsData{
//                let product = ProductsDataModel().parseOrderProductData(productItem)
//                productsDataModel.append(product)
//            }
//        }
        
        
        return productDetailDataModel
    }
    
}

class DescriptionKeys{
    var key:String?
    var val:String?
    
    func parsekeyData(_ json:JSON) -> DescriptionKeys{
        let model = DescriptionKeys()
        model.key = json["key"].stringValue
        model.val = json["val"].stringValue
        return model
    }
}

class SampleOrderDataModel{
    var id:Int?
    var name:String?
    var slug:String?
    var details:String?
    var price:String?
    var description:String?
    var featured:Int?
    var quantity:Int?
    var dimention:String?
    var weight:String?
    var category:String?
    var cabinate_type:Int?
    var sub_cabinate_type:Int?
    var image:String?
    var images:String?
    var is_sample:Bool?
    var created_at:String?
    var updated_at:String?
    
    func parseSampleData(_ json:JSON) -> SampleOrderDataModel{
        let data = SampleOrderDataModel()
        data.id = json["id"].intValue
        data.name = json["name"].stringValue
        data.slug = json["slug"].stringValue
        data.details = json["details"].stringValue
        data.price = json["price"].stringValue
        data.description = json["description"].stringValue
        data.featured = json["featured"].intValue
        data.quantity = json["quantity"].intValue
        data.dimention = json["dimention"].stringValue
        data.weight = json["weight"].stringValue
        data.category = json["category"].stringValue
        data.cabinate_type = json["cabinate_type"].intValue
        data.sub_cabinate_type = json["sub_cabinate_type"].intValue
        data.image = json["image"].stringValue
        data.is_sample = json["is_sample"].boolValue
        data.created_at = json["created_at"].stringValue
        data.updated_at = json["updated_at"].stringValue
        return data
    }
    
}


class ProductCategoryDataModel{
    var id:Int?
    var name:String?
    var slug:String?
    var frame_shape:String?
    var panel_style:String?
    var finish_stained:String?
    var finish_lacquered:String?
    var image:String?
    var description:String?
    var specification_booklet:String?
    var note:String?
    var gallery = [String]()
    var link:String?
    var descriptionKeys = [DescriptionKeys]()
    
    func parseCategoryData(_ json:JSON) -> ProductCategoryDataModel{
        let dataModel = ProductCategoryDataModel()
        dataModel.id = json["id"].intValue
        dataModel.name = json["name"].stringValue
        dataModel.slug = json["slug"].stringValue
        dataModel.frame_shape = json["frame_shape"].stringValue
        dataModel.panel_style = json["panel_style"].stringValue
        dataModel.finish_stained = json["finish_stained"].stringValue
        dataModel.finish_lacquered = json["finish_lacquered"].stringValue
        dataModel.image = json["image"].stringValue
        dataModel.description = json["description"].stringValue
        dataModel.specification_booklet = json["specification_booklet"].stringValue
        dataModel.note = json["note"].stringValue
        dataModel.link = json["link"].stringValue
        let galleryItem = json["gallery"].arrayValue
        for item in galleryItem{
            let item = item.stringValue
            dataModel.gallery.append(item)
        }
        let desData = json["description_keys"].arrayValue
        for desItem in desData{
            let des = DescriptionKeys().parsekeyData(desItem)
            dataModel.descriptionKeys.append(des)
        }
        return dataModel
    }
    
}
class ProductCabinateTypeDataModel{
    var id:Int?
    var name:String?
    var image:String?
    
    func parseCabinateTypeData(_ json:JSON) -> ProductCabinateTypeDataModel{
        let data = ProductCabinateTypeDataModel()
        data.id = json["id"].intValue
        data.name = json["name"].stringValue
        data.image = json["image"].stringValue
        return data
    }
}

class ProductSubCabinateTypeDataModel{
    var id:Int?
    var name:String?
    
    func parseSubCabinateTypeData(_ json:JSON) -> ProductSubCabinateTypeDataModel{
        let data = ProductSubCabinateTypeDataModel()
        data.id = json["id"].intValue
        data.name = json["name"].stringValue
        return data
    }
}

class ProductsDataModel{
    var id:Int?
    var name:String?
    var slug:String?
    var details:String?
    var price:String?
    var salePrice:String?
    var actualPrice:String?
    var description:String?
    var dimention:String?
    var weight:String?
    var inCart:Int?
    var inWishlist:Int?
    var image:String?
    var in_cart_rowId:String?
    var in_wishlist_rowId:String?
    
    func parseOrderProductData(_ json:JSON) -> ProductsDataModel{
        let data = ProductsDataModel()
        data.id = json["id"].intValue
        data.name = json["name"].stringValue
        data.slug = json["slug"].stringValue
        data.details = json["details"].stringValue
        data.price = json["your_price"].stringValue
        data.salePrice = json["sale_price"].stringValue
        data.actualPrice = json["price"].stringValue
        data.description = json["description"].stringValue
        data.dimention = json["dimention"].stringValue
        data.weight = json["weight"].stringValue
        data.inCart = json["in_cart"].intValue
        data.inWishlist = json["in_wishlist"].intValue
        data.image = json["image"].stringValue
        data.in_cart_rowId = json["in_cart_rowId"].stringValue
        data.in_wishlist_rowId = json["in_wishlist_rowId"].stringValue
        return data
    }
}


   
class OurTeamModel{
    var id:Int?
    var name:String?
    var designation:String?
    var details:String?
    var image:String?
    
    func parseOurTeamData(_ json:JSON) -> OurTeamModel{
        let data = OurTeamModel()
        data.id = json["id"].intValue
        data.name = json["name"].stringValue
        data.image = json["image"].stringValue
        data.details = json["about"].stringValue
        data.designation = json["designation"].stringValue
        return data
    }
}
