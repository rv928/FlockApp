//
//  FeedList.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct Kstream : Codable {
    let current_page : Int?
    let data : [Data]?
    let first_page_url : String?
    let from : Int?
    let next_page_url : String?
    let path : String?
    let per_page : Int?
    let prev_page_url : String?
    let to : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case current_page = "current_page"
        case data = "data"
        case first_page_url = "first_page_url"
        case from = "from"
        case next_page_url = "next_page_url"
        case path = "path"
        case per_page = "per_page"
        case prev_page_url = "prev_page_url"
        case to = "to"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        data = try values.decodeIfPresent([Data].self, forKey: .data)
        first_page_url = try values.decodeIfPresent(String.self, forKey: .first_page_url)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        next_page_url = try values.decodeIfPresent(String.self, forKey: .next_page_url)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        prev_page_url = try values.decodeIfPresent(String.self, forKey: .prev_page_url)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
    }
    
}

struct Feed : Codable {
    let id : Int?
    let title : String?
    let tag_line : String?
    let short_description : String?
    let title_image_url : String?
    let description_image_url : String?
    let article_url : String?
    let author : String?
    let article_type : String?
    let published_date : String?
    let tags : String?
    let filtertags : String?
    let likes : Int?
    let comments : Int?
    let shares : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case tag_line = "tag_line"
        case short_description = "short_description"
        case title_image_url = "title_image_url"
        case description_image_url = "description_image_url"
        case article_url = "article_url"
        case author = "author"
        case article_type = "article_type"
        case published_date = "published_date"
        case tags = "tags"
        case filtertags = "filtertags"
        case likes = "likes"
        case comments = "comments"
        case shares = "shares"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        tag_line = try values.decodeIfPresent(String.self, forKey: .tag_line)
        short_description = try values.decodeIfPresent(String.self, forKey: .short_description)
        title_image_url = try values.decodeIfPresent(String.self, forKey: .title_image_url)
        description_image_url = try values.decodeIfPresent(String.self, forKey: .description_image_url)
        article_url = try values.decodeIfPresent(String.self, forKey: .article_url)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        article_type = try values.decodeIfPresent(String.self, forKey: .article_type)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        filtertags = try values.decodeIfPresent(String.self, forKey: .filtertags)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
    }
}
