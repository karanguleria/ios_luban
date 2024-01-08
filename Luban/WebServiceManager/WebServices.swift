import UIKit
import Alamofire

class WebServices: NSObject {
    static var shared: WebServices {
        return WebServices()
    }
    private override init(){}
    
    func postDataRequest(urlString:String, params:[String:Any],
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        if showIndicator {
        Proxy.shared.showActivityIndicator()
        }
        print(urlString)
        print(params)
        AF.request(urlString, method: .post, parameters: params, encoding:  JSONEncoding.prettyPrinted, headers:self.generatingHeaderParams()).responseJSON { response in
             let res : ApiResponse?


            switch response.result {
                case .success:
                if response.data != nil {
                    if let JSON = response.value as? [String:Any] {
                        if JSON["success"] as? Bool == true {
                            res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                        } else {
                            res = ApiResponse(data: ["":""], success: false, message: JSON["message"] as? String ?? "Error")
                        }
                        completion(res!)
                    }
                }
            case .failure(let error):
                Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
            }
            if showIndicator {
            Proxy.shared.hideActivityIndicator()
            }
        }
    }
    
    func postMultipartDataRequest(urlString:String, params:[String:String],imageBefore:[UIImage],imageAfter:[UIImage],invoice:UIImage,
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        Proxy.shared.showActivityIndicator()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for i in 0..<imageBefore.count{
                guard let imgdata = imageBefore[i].jpegData(compressionQuality: 0.2) else{
                return
                }
            
                multipartFormData.append(imgdata, withName: "image_before_\(i+1)", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for i in 0..<imageAfter.count{
                guard let imgdata = imageAfter[i].jpegData(compressionQuality: 0.2) else{
                return
                }
                multipartFormData.append(imgdata, withName: "image_after_\(i+1)", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            guard let imgdata = invoice.jpegData(compressionQuality: 0.2) else{
            return
            }
            multipartFormData.append(imgdata, withName: "invoice", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
            
        }, to: urlString, usingThreshold: UInt64.init(), method: .post, headers: self.generatingHeaderParams())
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
                let res : ApiResponse?
               print(data,data.response?.statusCode,data.request)
               switch data.result {
                   case .success:
                   if data.data != nil {
                       if let JSON = data.value as? [String:Any] {
                           if JSON["success"] as? Bool == true {
                               res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                           } else {
                               res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                           }
                           completion(res!)
                       }
                   }
               case .failure(let error):
                   Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
               }
               Proxy.shared.hideActivityIndicator()
        })
        }
        
        
        
//        AF.request(urlString, method: .post, parameters: params, encoding:  JSONEncoding.prettyPrinted, headers:self.generatingHeaderParams()).responseJSON { response in
//             let res : ApiResponse?
//            print(response,response.response?.statusCode,response.request)
//            switch response.result {
//                case .success:
//
//                if response.data != nil {
//                    if let JSON = response.value as? [String:Any] {
//                        if JSON["success"] as? Bool == true {
//                            res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
//                        } else {
//                            res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
//                        }
//                        completion(res!)
//                    }
//                }
//            case .failure(let error):
//                Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
//            }
//            Proxy.shared.hideActivityIndicator()
//        }
//    }
    
    func postContactDataRequest(urlString:String, params:[String:String],attachment:[UIImage],
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        Proxy.shared.showActivityIndicator()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for i in 0..<attachment.count {
                guard let imgdata = attachment[i].jpegData(compressionQuality: 0.2) else{
                return
                }
            
                multipartFormData.append(imgdata, withName: "attachment\(i+1)", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
           
         for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
            
        }, to: urlString, usingThreshold: UInt64.init(), method: .post, headers: self.generatingHeaderParams())
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            let res : ApiResponse?
           print(data,data.response?.statusCode,data.request)
           switch data.result {
               case .success:
               if data.data != nil {
                   if let JSON = data.value as? [String:Any] {
                       if JSON["success"] as? Bool == true {
                           res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                       } else {
                           res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                       }
                       completion(res!)
                   }
               }
           case .failure(let error):
               Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
           }
           Proxy.shared.hideActivityIndicator()
        })
        
     
    }
    
    func uploadImgWithParamRequest(urlString:String, params:[String:String],paramImage:[UIImage],
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void) {
        Proxy.shared.showActivityIndicator()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for i in 0..<paramImage.count{
                guard let imgdata = paramImage[i].jpegData(compressionQuality: 0.2) else{
                return
                }
            
                multipartFormData.append(imgdata, withName: "avatar", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
           
           for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
            
        }, to: urlString, usingThreshold: UInt64.init(), method: .post, headers: self.generatingHeaderParams())
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            let res : ApiResponse?
           print(data,data.response?.statusCode,data.request)
           switch data.result {
               case .success:
               if data.data != nil {
                   if let JSON = data.value as? [String:Any] {
                       if JSON["success"] as? Bool == true {
                           res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                       } else {
                           res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                       }
                       completion(res!)
                   }
               }
           case .failure(let error):
               Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
           }
           Proxy.shared.hideActivityIndicator()
        })

    }
  
    func getDataRequest(urlString:String, showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        if showIndicator {
                       Proxy.shared.showActivityIndicator()
                   }
        debugPrint(Proxy.shared.accessTokenNil());
        AF.request(urlString, method: .get, encoding: URLEncoding.default, headers:self.generatingHeaderParams()).responseJSON { response in
             let res : ApiResponse?
            print(response,response.response?.statusCode, response.request)
            switch response.result {
            case .success:
                print(response)
                if response.data != nil {
                    if let JSON = response.value as? [String:Any] {
                        if JSON["success"] as? Bool == true {
                            res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                        } else {
                            res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                        }
                        completion(res!)
                    }
                }
            case .failure(let _):
                res = ApiResponse(data: ["":""], success: false, message: "Error")
                completion(res!)
//                Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
            }
            Proxy.shared.hideActivityIndicator()
        }
    }
    
    func deleteDataRequest(urlString:String,
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        Proxy.shared.showActivityIndicator()
        AF.request(urlString, method: .delete, encoding:  JSONEncoding.prettyPrinted, headers:self.generatingHeaderParams()).responseJSON { response in
             let res : ApiResponse?
            print(response,response.response?.statusCode,response.request)
            switch response.result {
                case .success:
               
                if response.data != nil {
                    if let JSON = response.value as? [String:Any] {
                        if JSON["success"] as? Bool == true {
                            res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                        } else {
                            res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                        }
                        completion(res!)
                    }
                }
            case .failure(let error):
                Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
            }
            Proxy.shared.hideActivityIndicator()
        }
    }
    
    func patchDataRequest(urlString:String,
                         showIndicator: Bool, completion: @escaping (ApiResponse) -> Void){
        Proxy.shared.showActivityIndicator()
        AF.request(urlString, method: .patch, encoding:  JSONEncoding.prettyPrinted, headers:self.generatingHeaderParams()).responseJSON { response in
             let res : ApiResponse?
            print(response,response.response?.statusCode,response.request)
            switch response.result {
                case .success:
               
                if response.data != nil {
                    if let JSON = response.value as? [String:Any] {
                        if JSON["success"] as? Bool == true {
                            res = ApiResponse(data: JSON, success: true, message:JSON["message"] as? String ?? "Successfully")
                        } else {
                            res = ApiResponse(data: ["":""], success: false, message: JSON["error"] as? String ?? "Error")
                        }
                        completion(res!)
                    }
                }
            case .failure(let error):
                Proxy.shared.displayStatusCodeAlert(error.errorDescription ?? "Server error", title: "Error")
            }
            Proxy.shared.hideActivityIndicator()
        }
    }
    
    func generatingHeaderParams() -> HTTPHeaders{
        var headerParam = [String:String]()
        if let token = UserDefaults.standard.value(forKey: "accessToken") as? String{
            if token != ""{
                headerParam["Authorization"] = "Bearer \(token)"
            }
        }
        return HTTPHeaders(headerParam)
    }
}
