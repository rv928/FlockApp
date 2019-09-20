//
//  BorderTextField.swift


import UIKit



class BorderTextField: UITextField {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setBorderTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBorderTextField()
    }
    
    func setBorderTextField() {
        self.backgroundColor = UIColor(hexColor: "#424040")
        self.textColor = UIColor(hexColor:"#FFFFFF")
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        self.font = UIConstant.Fonts.FONT_HELVETICA_REGULAR(16.0)
    }

}
