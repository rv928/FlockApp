//
//  FeedListCell.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Foundation

class FeedListCell: ReusableTableViewCell {

    ///Properties : -
    
    //Banner View
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    //Feed Basic Info
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var articleTypeLabel: AttributedLabel!
    @IBOutlet weak var authorLabel: AttributedLabel!
    @IBOutlet weak var pubDateLabel: AttributedLabel!
    @IBOutlet weak var articleLinkTextView: UITextView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var artistViewHeightConst: NSLayoutConstraint!
    
    
    var viewModel: FeedCellVMModel!
    var totalHeight:CGFloat = 0.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(viewModel: FeedCellVMModel) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        
        titleLabel.text = self.viewModel.title
        tagLineLabel.text = self.viewModel.tagLine
        self.articleTypeLabel.setAttributedTextColor(leadingText: "Type : ", trailingText: self.viewModel.articleType)
        self.authorLabel.setAttributedTextColor(leadingText: "Author : ", trailingText: self.viewModel.author)
        self.pubDateLabel.setAttributedTextColor(leadingText: "Published Date : ", trailingText: self.viewModel.author)
        articleLinkTextView.text = self.viewModel.articleLink
        descLabel.text = self.viewModel.desc

        if self.viewModel?.image != nil {
            DownloadManager.sharedManager.downloadImage(self.viewModel!.image,placeHolderImage: UIConstant.Images.noImageMedium, completion: { (image:UIImage?) -> Void in
                
                self.bannerImageView.image = image
            })
        }
        else {
            bannerImageView?.image = UIImage(named: UIConstant.Images.noImageSmall)!
        }
        self.calculateArtistInfoViewHeight()
    }
   
    //**********To Caleculate Artist Info ViewHeight *************
    
    func calculateArtistInfoViewHeight() {
        
        totalHeight = self.calculateLabelHeight(currentString: viewModel.title)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.tagLine)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.articleType)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.author)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.pubDate)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.articleLink)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.desc)
       
        self.artistViewHeightConst.constant =  totalHeight + 50
    }
  
    func calculateLabelHeight(currentString:String) -> CGFloat {
        let size = CGSize(width: SCREEN_WIDTH,height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: currentString).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font:UIConstant.Fonts.FONT_HELVETICA_REGULAR(16.0)], context: nil)
        return estimatedFrame.height
    }
    
}
// MARK:- TextView Delegate Methods

extension FeedListCell:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
