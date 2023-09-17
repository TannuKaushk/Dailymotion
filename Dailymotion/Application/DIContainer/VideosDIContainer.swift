//
//  VideosDIContainer.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import UIKit

final class VideosDIContainer {
    
    struct Dependencies {
        let apiDataService: NetworkService
        let imageDataService: ImageService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeVideosFlowCoordinator(navigationController: UINavigationController) -> VideosFlowCoordinator {
        return VideosFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - List
    func makeVideosListController() -> VideoListViewController {
        return VideoListViewController(viewModel: makeListViewModel())
    }
    func makeListViewModel() -> ListViewModel {
        return VideoListViewModelImpl(service: VideosServiceDetail(networkService: dependencies.apiDataService), imageService: dependencies.imageDataService)
    }
}
extension VideosDIContainer: VideosFlowCoordinatorDependencies {
    
}
