//
//  VideoFlowCoordinator.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import UIKit

protocol VideosFlowCoordinatorDependencies  {
    func makeVideosListController() -> VideoListViewController
}

final class VideosFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: VideosFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: VideosFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeVideosListController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
