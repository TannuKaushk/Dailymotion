//
//  AppDIContainer.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
/**
 Dependency Injection Container
 **/
final class AppDIContainer {
    
    lazy var apiDataTransferService: NetworkService = NetworkServiceImpl()
    lazy var imageDataTransferService: ImageService = ImageServiceImpl()
    
    // MARK: - DIContainers
    /// Creates a specialized dependency container for managing NetworkService  and ImageService dependencies
    /// - Returns: VideosDIContainer
    func makeVideosDIContainer() -> VideosDIContainer {
        let dependencies = VideosDIContainer.Dependencies(apiDataService: apiDataTransferService, imageDataService: imageDataTransferService)
        return VideosDIContainer(dependencies: dependencies)
    }
}
