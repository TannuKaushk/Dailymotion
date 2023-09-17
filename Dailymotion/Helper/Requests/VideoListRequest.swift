//
//  VideoListRequest.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
/**
 Video list fetch request
 */
struct VideoListRequest : NetworkRequest {
    let page: Int
    
    var method: HTTPMethod {
        return .GET
    }
    var serviceName: String {
        return Constant.URLs.videoURL
    }
}
extension VideoListRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case page = "page"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
    }
}

