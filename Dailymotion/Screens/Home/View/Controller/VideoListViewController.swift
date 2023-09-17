//
//  VideoListViewController.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import UIKit

class VideoListViewController: UIViewController {
    
    private var viewModel: ListViewModel
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Dailymotion"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoListTableViewCell.self, forCellReuseIdentifier: VideoListTableViewCell.cellID)
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadData()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Hide navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bindViewModel() {
        viewModel.didStartLoading = {
            LoadingView.show()
        }
        viewModel.didStopLoading = {
            LoadingView.hide()
        }
        viewModel.didShowError = { errorTitle, errorMessage in
            DispatchQueue.main.async {
                self.showAlert(title: errorTitle, message: errorMessage)
            }
        }
        viewModel.didReload = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
}
//MARK: - Tableview Delegate & Datasource
extension VideoListViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            viewModel.handlePagination(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:VideoListTableViewCell.cellID, for: indexPath) as? VideoListTableViewCell ?? VideoListTableViewCell(style: .default, reuseIdentifier: VideoListTableViewCell.cellID)
        cell.configure(with: viewModel.getVideoData(index: indexPath.row), imageService: viewModel.imageService)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row, controller: self)
    }
    
}

//MARK:- Initial Setup
extension VideoListViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkText]
        tableView.backgroundColor = .clear
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20.0),
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20.0),
            tableView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
        ])
    }
}
