//
//  WebServiceManager.swift
//
//  Created by Ravi Vora on 17/08/19.
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import UIKit

struct WebServiceConstants {
  static let baseURL = "https://gospark.app/api/v1/"
  static let k_APILogin = "login"
  static let k_APISignUp = "register"
  static let k_APIFeedList = "kstream"
}


class WebServiceManager: NSObject {
  
  static let sharedService = WebServiceManager()
  
    typealias WebServiceCompletionBlock = (_ data: [String:Any]?,_ error: Error?)->Void
  
    enum HTTPMethodType: Int {
        case POST = 0
        case GET
    }
  
    func requestAPI(headers:[String:String],url: String,parameter: [String: Any]?, httpMethodType: HTTPMethodType, completion: @escaping WebServiceCompletionBlock) {
   
    let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
    var request = URLRequest(url: URL(string: escapedAddress!)!)

    do {
        if parameter != nil {
            let postData = try JSONSerialization.data(withJSONObject: parameter!, options: [])
            request.httpBody = postData as Data
        }
        switch httpMethodType {
        case .POST:
            request.httpMethod = "POST"
        case .GET:
            request.httpMethod = "GET"
        }
        request.allHTTPHeaderFields = headers
    }
    catch let error {
        print(error.localizedDescription)
        return
    }
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        guard let data = data, error == nil else {                                                                 return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("Error in fetching response")
        }
        do {
            //create json object from data
            var jsonString = String()
            jsonString = String(data: data, encoding: String.Encoding.utf8)!
            print("======================================================================")
            print("jsonString\n \(jsonString)")
            
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                completion(json,nil)
            }
            else {
                completion(nil,error)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(nil,error)
        }
    }
    task.resume()
  }
}
