//
//  FeedCellVMModel.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class FeedCellVMModel:FeedCellVMRepresentable,Equatable {
    
    static func == (lhs: FeedCellVMModel, rhs: FeedCellVMModel) -> Bool {
        return true
    }
    
    
    var title: String = ""
    var image: String = ""
    var tagLine: String = ""
    var articleType: String = ""
    var author: String = ""
    var pubDate: String = ""
    var articleLink: String = ""
    var desc: String = ""
    var artistTags: [String] = []
    var totalHeight:CGFloat = 0.0
    
    // Data Model
    var feed: Feed!
    
    init(feed: Feed) {
        self.feed = feed
        configureOutput()
    }
    
    func configureOutput() {
        self.title = feed.title!
        self.image = feed.title_image_url == nil ? "" :feed.title_image_url!
        self.tagLine = feed.tag_line == nil ? "" :feed.tag_line!
        self.articleType = feed.article_type!
        self.author = feed.author == nil ? "" :feed.author!
        self.pubDate = feed.published_date == nil ? "" :feed.published_date!
        self.articleLink = feed.article_url == nil ? "" :feed.article_url!
        self.desc = feed.short_description == nil ? "" :feed.short_description!
        self.artistTags =  feed.tags == nil ? [] : (feed.tags!).components(separatedBy: ", ")
    }
    
    /*
     * This method will calculate Height for FeedCellVMModel.
     */
    
    func calculateHeightRow(viewModel: FeedCellVMModel) -> CGSize {
       
        totalHeight = self.calculateLabelHeight(currentString: viewModel.title)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.tagLine)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.articleType)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.author)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.pubDate)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.articleLink)
        totalHeight += self.calculateLabelHeight(currentString: viewModel.desc)
        return CGSize(width: SCREEN_WIDTH,height: totalHeight+200+50)
    }
    
    func calculateLabelHeight(currentString:String) -> CGFloat {
        let size = CGSize(width: SCREEN_WIDTH,height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: currentString).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font:UIConstant.Fonts.FONT_HELVETICA_REGULAR(16.0)], context: nil)
        return estimatedFrame.height + 5
    }
}

protocol FeedCellVMRepresentable {
    
    // Output
    var title: String { get }
    var image: String { get }
    var tagLine: String { get }
    var articleType: String { get }
    var author: String { get }
    var pubDate: String { get }
    var articleLink: String { get }
    var desc: String { get }
    var artistTags: [String] { get }
}


