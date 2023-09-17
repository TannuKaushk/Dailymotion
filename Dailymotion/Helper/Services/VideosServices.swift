//
//  VideosServices.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
/**
 VideosService protocal to handle Network methods
 */
protocol VideosService {
    func getVideoList(for page:Int) async throws -> VideosList
}

final class VideosServiceDetail : VideosService {
    
    fileprivate var networkService : NetworkService
    
    init(networkService : NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: Network methods
    func getVideoList(for page:Int) async throws -> VideosList {
        do {
            let videoRequest = VideoListRequest(page: page)
            return try await networkService.http(request: videoRequest)
        } catch {
            throw error
        }
    }
}
