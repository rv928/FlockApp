//
//  AlertManager.swift
//
//  Created by Ravi vora on 17/08/19.
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import Foundation
import UIKit

struct AlertManager {
  
  let rootController: UIViewController? = {
    let app = UIApplication.shared.delegate as! AppDelegate
    return app.window?.rootViewController
  }()
  
    func showAlert(withMessage message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        rootController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithBlock(viewController: UIViewController!,strMessage:String!,buttonTitle:String!,handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: APP_NAME , message:strMessage, preferredStyle:.alert)
        let okAction = UIAlertAction(title: buttonTitle, style:.default) {
            (result : UIAlertAction) -> Void in
            handler!(result)
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

