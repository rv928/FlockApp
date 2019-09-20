//
//  LoginUser.swift
//  FlockApp
//
//  Created by Admin on 17/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct LoginUser : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let email_verified_at : String?
    let api_token : String?
    let rate_limit : String?
    let wallet_balance : Int?
    let facebook : Int?
    let google : Int?
    let twitter : Int?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case email = "email"
        case email_verified_at = "email_verified_at"
        case api_token = "api_token"
        case rate_limit = "rate_limit"
        case wallet_balance = "wallet_balance"
        case facebook = "facebook"
        case google = "google"
        case twitter = "twitter"
        case user_type = "user_type"
        case deleted_at = "deleted_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        api_token = try values.decodeIfPresent(String.self, forKey: .api_token)
        rate_limit = try values.decodeIfPresent(String.self, forKey: .rate_limit)
        wallet_balance = try values.decodeIfPresent(Int.self, forKey: .wallet_balance)
        facebook = try values.decodeIfPresent(Int.self, forKey: .facebook)
        google = try values.decodeIfPresent(Int.self, forKey: .google)
        twitter = try values.decodeIfPresent(Int.self, forKey: .twitter)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

