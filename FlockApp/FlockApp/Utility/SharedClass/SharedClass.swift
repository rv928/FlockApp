//
//  SharedClass.swift


import UIKit
import Foundation

class SharedClass:NSObject {
    
    static let sharedInstance : SharedClass = {
        let instance = SharedClass()
        return instance
    }()
    
    var SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.width
    
    // MARK:- ProgressHUD methods
    
    func showProgressHUD(_ isShow:Bool) {
      
        DispatchQueue.main.async {
            if isShow == true {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let loaderView: LoaderView = LoaderView(frame: CGRect(x: 0,y: 0, width: SharedClass.sharedInstance.SCREEN_WIDTH, height: SharedClass.sharedInstance.SCREEN_HEIGHT))
                loaderView.bgView.center = appDelegate.window!.center
                appDelegate.window?.addSubview(loaderView)
                appDelegate.window?.bringSubviewToFront(loaderView)
                loaderView.showLoaderView()
            }
            else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                for view in appDelegate.window!.subviews {
                    if view.isKind(of: LoaderView.self) {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // MARK:- Reachability methods
    
    func hasConnectivity(completion: @escaping (_ interConnected:Bool) -> Void) {
        
        let reachability = Reachability()
        reachability.checkInternet { (isConnected) in
            completion(isConnected)
        }
    }
    
    // MARK:- UIColor Modification methods
    
    
    func colorWithHexStringAndAlpha(_ hexString: String, alpha:CGFloat) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    
}



