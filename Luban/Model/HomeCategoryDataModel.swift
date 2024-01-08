//
//  HomeCategoryDataModel.swift
//  Luban
//
//  Created by King on 8/14/20.
//

import SwiftyJSON
import UIKit

class HomeCategoryDataModel{
    
    var categoryDataModel = [CategoryDataModel]()
    var sliderDataModel = [SliderDataModel]()
    var subcategoryDataModel = [SubCategoryDataModel]()
    var sortDataModel = [SortDataModel]()
    var frameShapeDataModel = [FilterDataModel]()
   
    
    func parseDatafromJson(_ json:JSON) -> HomeCategoryDataModel{
        let homeCategoryDataModel = HomeCategoryDataModel()
        let catData = json["category"].arrayValue
        for cat in catData{
            let category = CategoryDataModel().parserCatData(cat)
            homeCategoryDataModel.categoryDataModel.append(category)
        }
        let sliderData = json["slider"].arrayValue
        for slider in sliderData{
            let slide = SliderDataModel().parseSliderData(slider)
            homeCategoryDataModel.sliderDataModel.append(slide)
        }
        
        let subCatData = json["subcategory"].arrayValue
        for subCat in subCatData{
            let category = SubCategoryDataModel().parseSubCatData(subCat)
            homeCategoryDataModel.subcategoryDataModel.append(category)
        }
        
        let sortData = json["sort"].arrayValue
        for sort in sortData{
            let category = SortDataModel().parseSortData(sort)
            homeCategoryDataModel.sortDataModel.append(category)
        }
        let frame_shapeData = json["filter"].arrayValue
        for frame_shape in frame_shapeData{
            let category = FilterDataModel().parseFilterData(frame_shape)
            homeCategoryDataModel.frameShapeDataModel.append(category)
        }
//        let panel_styleData = json["panel_style"].arrayValue
//        for panel_style in panel_styleData{
//            let category = PanelStyleDataModel().parsePanelStyleData(panel_style)
//            homeCategoryDataModel.panelStyleDataModel.append(category)
//        }
//        let finishData = json["finish"].arrayValue
//        for finish in finishData{
//            let category = FinishDataModel().parseFinishData(finish)
//            homeCategoryDataModel.finishDataModel.append(category)
//        }
        return homeCategoryDataModel
    }
   
}

class CategoryDataModel{
    
    var title:String?
    var slug:String?
    var img:String?
    
    func parserCatData(_ json:JSON) -> CategoryDataModel{
        let categoryDataModel = CategoryDataModel()
        categoryDataModel.title = json["title"].stringValue
        categoryDataModel.slug = json["slug"].stringValue
        categoryDataModel.img = json["image"].stringValue
        return categoryDataModel
    }
   
}
class SliderDataModel{
    
    var title:String?
    var id:Int?
    var img:String?
    
    func parseSliderData(_ json:JSON) -> SliderDataModel{
        let sliderDataModel = SliderDataModel()
        sliderDataModel.title = json["title"].stringValue
        sliderDataModel.id = json["id"].intValue
        sliderDataModel.img = json["image"].stringValue
        return sliderDataModel
    }
   
}

class SubCategoryDataModel{
    var title = String()
    var slug = String()
    var image = String()
    var sale = String()
    var id = Int()
    
    func parseSubCatData(_ json:JSON) -> SubCategoryDataModel{
        let subCategoryDataModel = SubCategoryDataModel()
        subCategoryDataModel.id = json["id"].intValue
        subCategoryDataModel.title = json["title"].stringValue
        subCategoryDataModel.slug = json["slug"].stringValue
        subCategoryDataModel.image = json["image"].stringValue
        subCategoryDataModel.sale = json["sale"].stringValue
        return subCategoryDataModel
    }
}
class SortDataModel{
    var val = String()
    var name = String()
    
    func parseSortData(_ json:JSON) -> SortDataModel{
        let dataModel = SortDataModel()
        dataModel.val = json["val"].stringValue
        dataModel.name =  json["name"].stringValue
        return dataModel
    }
}
class FilterDataModel{
    var filterVal = [FilterValModel]()
    var name = String()
    
    func parseFilterData(_ json:JSON) -> FilterDataModel{
        let dataModel = FilterDataModel()
        dataModel.name =  json["title"].stringValue
        let frame_shapeData = json["val"].arrayValue
        for frame_shape in frame_shapeData{
            let category = FilterValModel().parsePanelStyleData(frame_shape)
            dataModel.filterVal.append(category)
        }
        return dataModel
    }
}
class FilterValModel{
    var val = String()
    var name = String()
    
    func parsePanelStyleData(_ json:JSON) -> FilterValModel{
        let dataModel = FilterValModel()
        dataModel.val = json["val"].stringValue
        dataModel.name =  json["name"].stringValue
        return dataModel
    }
}
//class FinishDataModel{
//    var val = String()
//    var name = String()
//
//    func parseFinishData(_ json:JSON) -> FinishDataModel{
//        let dataModel = FinishDataModel()
//        dataModel.val = json["val"].stringValue
//        dataModel.name =  json["name"].stringValue
//        return dataModel
//    }
//}

