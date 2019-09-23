//
//  LoaderView.swift
//
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var view: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        bgView.layer.cornerRadius = 12.0
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LoaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func showLoaderView() {
        self.indicatorView?.startAnimating()
    }
    
    func hideLoaderView() {
        self.indicatorView?.stopAnimating()
    }
}
