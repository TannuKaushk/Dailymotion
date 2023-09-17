//
//  Constants.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
/**
 Struct to hold static strings
 */
struct Constant {
    static let baseURL: String = "https://api.dailymotion.com"
    static let videoURL: String = "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"
    struct URLs {
        static let videoURL: String = "videos?fields=description,id,title,thumbnail_url,created_time"
    }
}

enum EnumKeys: String {
case yesterday = "yesterday"
case today = "today"
}
