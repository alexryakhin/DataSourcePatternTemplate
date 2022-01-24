//
//  ImageInfoView.swift
//  DataSourcePatternTemplate
//
//  Created by Alexander Ryakhin on 1/24/22.
//

import UIKit

final class ImageInfoView: UIView {
    // we should have this weak instance of our dataSource protocol
    weak var dataSource: ImageInfoViewDataSource?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        // make sure we have our dataSourse
        guard let dataSource = dataSource else { return }

        // once we have our dataSource, let us assign its data to our views
        titleLabel.text = dataSource.imageInfoViewTitleFor(self)

        guard let imageURL = dataSource.imageInfoViewImageURLFor(self) else { return }

        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { make in
            make.height.width.equalToSuperview().offset(-frame.width * 0.35)
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    // like all tableViews and collections have reload data
    func reloadData() {
        configure()
    }
}
