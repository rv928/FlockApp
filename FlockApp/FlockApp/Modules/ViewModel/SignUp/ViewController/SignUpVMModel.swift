//
//  SignUpVMModel.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class SignUpVMModel {
    
    var signupFetcher: FeedWSDataFetcherProtocol!
    /*
     * This method will create Dependency Injection
     */
    init(signupFetcher:FeedWSDataFetcherProtocol) {
        self.signupFetcher = signupFetcher
    }
    
    /*
     This method will do signup.
     */
    func signupWSCall(inputDict:[String:Any],completion: @escaping (Bool?)->()) {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        FeedWSManager().signupWS(inputDict: inputDict) { (signupDict,error) in
            SharedClass.sharedInstance.showProgressHUD(false)
            
            if signupDict != nil {
                let isSignUp:Bool = signupDict?["success"] as! Bool
                completion(isSignUp)
            }
        }
    }
}
