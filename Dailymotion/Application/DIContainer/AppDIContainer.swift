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
    func makeVideosDIContainer() -> VideosDIContainer {
        let dependencies = VideosDIContainer.Dependencies(apiDataService: apiDataTransferService, imageDataService: imageDataTransferService)
        return VideosDIContainer(dependencies: dependencies)
    }
}
