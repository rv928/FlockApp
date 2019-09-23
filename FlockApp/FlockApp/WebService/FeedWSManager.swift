//
//  UserWSManager.swift
//
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import Foundation

protocol FeedWSDataFetcherProtocol {
    func loginWS(inputDict:[String:Any],completion: @escaping ([String:Any]?, _ error: Error?)->())
}

struct FeedWSManager:FeedWSDataFetcherProtocol {
    
    /*
     This method will do login.
     */
    func loginWS(inputDict:[String:Any],completion: @escaping ([String:Any]?, _ error: Error?)->()) {
        
        SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:Bool?) -> Void in
            
            if checkConnection == false {
                DispatchQueue.main.async {
                    AlertManager().showAlert(withMessage: MessageConstant.internetMessage, title: APP_NAME)
                    SharedClass.sharedInstance.showProgressHUD(false)
                }
                return
            }
        })
        
        let urlString:String = WebServiceConstants.baseURL + WebServiceConstants.k_APILogin
        
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "3332fafc-80a3-4aed-8ffb-9b0fb2b92177"
        ]
        
        WebServiceManager.sharedService.requestAPI(headers: headers, url: urlString, parameter: inputDict, httpMethodType: .POST) { (response, error) in
            
            guard let data:[String:Any] = response?["user"] as? [String : Any] else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
    
    
    /*
     This method will do signup.
     */
    func signupWS(inputDict:[String:Any],completion: @escaping ([String:Any]?, _ error: Error?)->()) {
        
        SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:Bool?) -> Void in
            
            if checkConnection == false {
                DispatchQueue.main.async {
                    AlertManager().showAlert(withMessage: MessageConstant.internetMessage, title: APP_NAME)
                    SharedClass.sharedInstance.showProgressHUD(false)
                }
                return
            }
        })
        
        let urlString:String = WebServiceConstants.baseURL + WebServiceConstants.k_APISignUp
        
        let headers = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Postman-Token": "596e98bc-d152-4737-ade0-a64313d7b90a"
        ]
        
        WebServiceManager.sharedService.requestAPI(headers: headers, url: urlString, parameter: inputDict, httpMethodType: .POST) { (response, error) in
            
            guard let data:[String:Any] = response else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
    
    
    /*
     This method will fetch feedList.
     */
    func feedListWS(completion: @escaping ([String:Any]?, _ error: Error?)->()) {
        
        SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:Bool?) -> Void in
            
            if checkConnection == false {
                DispatchQueue.main.async {
                    AlertManager().showAlert(withMessage: MessageConstant.internetMessage, title: APP_NAME)
                    SharedClass.sharedInstance.showProgressHUD(false)
                }
                return
            }
        })
        
        let urlString:String = WebServiceConstants.baseURL + WebServiceConstants.k_APIFeedList
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer H5X1Hmd9GasItkzZMI5tElzcHds9KEQiIBI8KOXNBhDhPuvWWHBvGabUlxf7",
            "Cache-Control": "no-cache",
            "Postman-Token": "d82ad96f-6df9-4089-b3cc-e410dd6b9204"
        ]
        
        WebServiceManager.sharedService.requestAPI(headers: headers, url: urlString, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data:[String:Any] = response else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
 }
