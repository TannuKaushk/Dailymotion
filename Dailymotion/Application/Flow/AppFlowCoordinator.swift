//
//  AppFlowCoordinator.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import UIKit
/**
 AppFlowCoordinator to handle flow logic
 */
final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let videosSceneDIContainer = appDIContainer.makeVideosDIContainer()
        let flow = videosSceneDIContainer.makeVideosFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
