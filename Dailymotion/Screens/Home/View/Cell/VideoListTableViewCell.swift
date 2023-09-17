//
//  VideoListTableViewCell.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {
    static let cellID = "VideoListTableViewCell"
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let ImageAndTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.clipsToBounds = true
        stackView.alignment = .leading
        return stackView
    }()
    
    private let VerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initViews()
    }
    
    private func initViews() {
        backgroundColor = .clear
        contentView.addSubview(VerticalStackView)
        configureConstraints()
        [itemImageView,
         titleLabel].forEach { ImageAndTitleStackView.addArrangedSubview($0) }
        [ImageAndTitleStackView,
         discriptionLabel,
         dateLabel].forEach { VerticalStackView.addArrangedSubview($0) }
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            VerticalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            VerticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            VerticalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            VerticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor, multiplier: 16/9)
        ])
    }
    
    //MARK: - Cell setup
    
    func configure(with model: ListData?, imageService: ImageService?) {
        let placeholderImage = "placeholderIcon"
        if let imagePath = model?.thumbnail_url {
            do {
                Task {
                    let imageData = try await imageService?.load(urlPath: imagePath)
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData!) {
                            self.itemImageView.image = image
                        } else {
                            self.itemImageView.image = UIImage(named: placeholderImage)
                        }
                    }
                }
            }
        } else {
            //add placeholder
            itemImageView.image = UIImage(named: placeholderImage)
        }
        titleLabel.text = model?.title
        discriptionLabel.text = String(htmlEncodedString: model?.description ?? "")
        guard let createDate = Utility.getDateAndTimeStamp(timestamp: Int64(model?.created_time ?? 0)) else { return }
        dateLabel.text = Utility.getElapsedInterval(FromDate: createDate)
    }
    
}




