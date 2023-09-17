//
//  ImageServices.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 17/09/23.
//

import Foundation
/**
 ImageService with caching using NSCache
 */
protocol ImageService {
    func load(urlPath: String) async throws -> Data
}

final class ImageServiceImpl: ImageService {
    
    private let cachedImages = NSCache<NSURL, NSData>()
    //MARK:- Returns the cached image if available, otherwise asynchronously loads and caches it.
    func load(urlPath: String) async throws -> Data {
        guard let url = URL(string: urlPath) else {
            throw HTTPError.invalidRequest
        }
        if let cachedImageData = cachedImages.object(forKey: url as NSURL) {
            return cachedImageData as Data
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.cachedImages.setObject(data as NSData, forKey: url as NSURL, cost: data.count)
            return data
            
        } catch {
            throw HTTPError.invalidRequest
        }
    }
}
