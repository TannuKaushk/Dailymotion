//
//  VideosServices.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
/**
 VideosService protocol to handle Network methods
 */
protocol VideosService {
    func getVideoList(for page:Int) async throws -> VideosList
}

final class VideosServiceDetail : VideosService {
    
    fileprivate var networkService : NetworkService
    
    init(networkService : NetworkService) {
        self.networkService = networkService
    }
    
    /// Retrieves a list of videos from videos API for a specified page.
    /// - Parameter
    ///   - page: Page number for which list of videos will be fetched.
    /// - Returns: VideosList Object containing list of videos for specified page.
    func getVideoList(for page:Int) async throws -> VideosList {
        do {
            let videoRequest = VideoListRequest(page: page)
            return try await networkService.http(request: videoRequest)
        } catch {
            throw error
        }
    }
}
