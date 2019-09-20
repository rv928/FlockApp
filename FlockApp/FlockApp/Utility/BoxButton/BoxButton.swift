//
//  BoxButton.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class BoxButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setButtonContrast()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setButtonContrast()
    }
    
    func setButtonContrast() {
        
        if self.isSelected {
            self.backgroundColor = UIColor(hexColor: "#FF4800")
            self.layer.borderColor = UIColor(hexColor: "#FF4800")?.cgColor
            self.setTitleColor(UIColor.white, for: .normal)
        }
        else {
            self.backgroundColor = UIColor.white
            self.layer.borderColor = UIColor(hexColor: "#DEDBD9")?.cgColor
            self.setTitleColor(UIColor(hexColor: "#FF4800"), for: .normal)
        }
        self.layer.borderWidth = 2.0
        let titleFont = UIConstant.Fonts.FONT_HELVETICA_BOLD(12.0)
        self.titleLabel?.font = titleFont
        self.layer.cornerRadius = 4.0
    }
    
}
