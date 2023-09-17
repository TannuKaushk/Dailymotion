//
//  VideosListModel.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation

// MARK:- Videos List Model
struct VideosList : Codable {
    let page, limit, total : Int
    let explicit, has_more : Bool?
    let list : [ListData]
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case limit = "limit"
        case explicit = "explicit"
        case total = "total"
        case has_more = "has_more"
        case list = "list"
    }
}

// MARK: - ListData
struct ListData : Codable {
    let description, title, thumbnail_url : String?
    let id : String?
    let created_time : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
        case id = "id"
        case title = "title"
        case thumbnail_url = "thumbnail_url"
        case created_time = "created_time"
    }
}
