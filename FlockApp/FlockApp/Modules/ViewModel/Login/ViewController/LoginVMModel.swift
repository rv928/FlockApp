//
//  LoginVMModel.swift
//  FlockApp
//
//  Created by Admin on 17/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class LoginVMModel {
    
    // Input
    var viewDidLoad: () -> () = { }
    var loginFetcher: FeedWSDataFetcherProtocol!
    
    var dataModel: [LoginUser]!
    
    /*
     * This method will create Dependency Injection
     */
    init(loginFetcher:FeedWSDataFetcherProtocol) {
        self.loginFetcher = loginFetcher
    }
    
    /*
     This method will do login.
     */
    func loginWSCall(inputDict:[String:Any],completion: @escaping (LoginUser?)->()) {
       
        SharedClass.sharedInstance.showProgressHUD(true)
        
        FeedWSManager().loginWS(inputDict: inputDict) { (loginDict,error) in
            SharedClass.sharedInstance.showProgressHUD(false)
            
            if loginDict != nil {
                let objUser:LoginUser = try! DictionaryDecoder().decode(LoginUser.self, from: loginDict!)
                completion(objUser)
            }
        }
    }
}
