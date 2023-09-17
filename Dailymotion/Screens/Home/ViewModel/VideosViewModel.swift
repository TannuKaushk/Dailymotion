//
//  VideosViewModel.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import Foundation
import AVKit


protocol VideoListViewModelInput {
    func loadData(_ page: Int)
    func didSelectItem(at index: Int, controller: VideoListViewController)
    func handlePagination(at index: Int)
}
protocol VideoListViewModelOutput {
    var didShowError: ((String, String) -> Void)? {get set}
    var didReload: (() -> Void)? {get set}
    var didStartLoading: (() -> Void)? {get set}
    var didStopLoading: (() -> Void)? {get set}
    var imageService: ImageService {get}
    func getListCount() -> Int
    func getVideoData(index: Int) -> ListData
}

protocol ListViewModel : VideoListViewModelInput, VideoListViewModelOutput {}

final class VideoListViewModelImpl: ListViewModel {
    
    var didStartLoading: (() -> Void)?
    var didStopLoading: (() -> Void)?
    var didShowError: ((String, String) -> Void)?
    var didReload: (() -> Void)?
    
    private var service: VideosService
    var imageService: ImageService
    private enum State {
        case loading, loaded, paginating, error
    }
    private var state = State.loading
    
    init(service: VideosService, imageService: ImageService) {
        self.service = service
        self.imageService = imageService
    }
    
    private var data: VideosList?
    private var list: [ListData] = [] {
        didSet {
            didReload?()
        }
    }
    
    /// Fetches data from a remote server for a specified page and updates the view model's state.
    /// - Parameter
    ///   - page: Page Number for which Data is to be Fetched
    private func fetchData(_ page: Int) async {
        do {
            async let videoData: VideosList = try await service.getVideoList(for: page)
            let fetchedData = try await videoData
            self.data = fetchedData
            self.didStopLoading?()
            self.list.append(contentsOf: fetchedData.list)
            self.state = .loaded
        } catch let error as HTTPError {
            //Handle error here
            self.state = .error
            self.didStopLoading?()
            self.didShowError?(error.errorTitle, error.errorDescription)
        } catch {
            self.state = .error
            self.didStopLoading?()
            self.didShowError?("Error", error.localizedDescription)
        }
    }
    
}

///VideoListViewModelInput methods
extension VideoListViewModelInput {
    func loadData(_ page: Int = 1) {
        return loadData(page)
    }
}
extension VideoListViewModelImpl {
    func loadData(_ page: Int) {
        self.didStartLoading?()
        Task {
            await self.fetchData(page)
        }
    }
    //MARK: Play Video
    func didSelectItem(at index: Int, controller: VideoListViewController) {
        // Check if the cell has a video URL
        if let videoURL = URL(string: Constant.videoURL) {
            let playerViewController = AVPlayerViewController()
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
            controller.present(playerViewController, animated: true) {
                player.play()
            }
        }
    }
    
    func handlePagination(at index: Int) {
        if let videoData = self.data, state != .paginating, index == list.count - 1, videoData.total > list.count {
            loadData(videoData.page + 1)
        }
    }
}
///ListViewModelOutput methods
extension VideoListViewModelImpl {
    
    func getListCount() -> Int {
        return list.count
    }
    
    func getVideoData(index: Int) -> ListData {
        return list[index]
    }
}
