//
//  APIManager.swift
//  Code Optimization
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager{
    
    //*********TYPE ONE******************//

    static let sharedInstance = APIManager()
    private init() {

    }
    
    //*********TYPE TWO******************//
//    class var shareInstance: APIManager {
//        struct Static {
//            static let instance = APIManager()
//        }
//        return Static.instance
//    }
    
    //MARK: BASE URL
    
     func getServerPath() -> String {
        let serverPath: String = BASE_URL
        // serverPath.append(MiddlePath)
        return serverPath
    }
    //MARK: MAKE FUL PATH
    
     func getFullPath(path: String) -> String {
        var fullPath = APIManager.sharedInstance.getServerPath()
        fullPath.append("/")
        fullPath.append(path)
        let escapedAddress: String = fullPath.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return escapedAddress
    }
    
    //MARK: SET REQUEST
    
     func setRequest(dict: NSDictionary, url: String)->NSMutableURLRequest{
        let request = NSMutableURLRequest(url: NSURL.init(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 50 // 10 secs
        let values = ["key": "value"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
        return request
    }
    
    // MARK: SET HEADER
    
     func setHeader() -> Dictionary<String, String>
    {
        let headers : Dictionary<String, String> = ["user_id": "2", "device_tokken":"dfdfdf", "lang" : ""];
        return headers
    }
    //MARK: Convert to JSON
    
     func json(from object:AnyObject) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    // MARK: MULTIPART POST
    func apiCall( _ apiName : String , _ param : NSDictionary,  completionHandler: @escaping(Bool , JSON)-> Void){
        let path : String = APIManager.sharedInstance.getFullPath(path: apiName)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in param	 {
                    print(key , value)
                    if value is NSArray{
                        let str = APIManager.sharedInstance.json(from:(value as AnyObject))
                        multipartFormData.append((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
                    }
                    else{
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
                    }
                }
        },
            to: path,
           // headers:APIManager.sharedInstance.setHeader(),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        debugPrint(response)
                        let data = JSON(response)
                        completionHandler(true, data)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    completionHandler(false, JSON(encodingError))
                }
        }
        )
    }
    
    //get request
    func apiCall1( _ apiName : String , _ param : NSDictionary,  completionHandler: @escaping(Bool , JSON)-> Void){
        let path : String = APIManager.sharedInstance.getFullPath(path: apiName)
        Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            debugPrint(response)
            if let dict = response.result.value{
                let data = JSON(response.result.value)
                completionHandler(true, data)
            }
            else{
                completionHandler(false, JSON(response.error))
            }
        }
    }
    
}
