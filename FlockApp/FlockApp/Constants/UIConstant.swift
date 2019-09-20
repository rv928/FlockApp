//
//  UIConstant.swift
//
//  Created by Ravi vora on 17/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit


let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.width

struct UIConstant  {
    
    static let appColor = "#D75332"
    static let appTextColor = "#000000"
    static let navTextColor = "#FFFFFF"
    static let tagBgColor = "#9ACD32"
    static let tagTextColor = "#FFFFFF"
    
    struct ProgressHUD {
        static let bgColor = "#FFFFFF"
        static let TextColor = "#FF6666"
    }
    
    struct Images {
        static let backIcon = "icon-back"
        static let noImageSmall = "no-img-small"
        static let noImageMedium = "no-img-medium"
        static let noImageLarge = "no-img-large"
        static let leftBubble = "left_bubble"
        static let rightBubble = "right_bubble"
        static let logouticon = "icon_logout"
    }
    
    struct Fonts {
        
        static func FONT_HELVETICA_BOLD(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica-Bold", size: _size)!
            return font
        }
        
        static func FONT_HELVETICA_REGULAR(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica", size: _size)!
            return font
        }
    }
}
