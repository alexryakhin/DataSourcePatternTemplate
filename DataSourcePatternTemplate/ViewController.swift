//
//  ViewController.swift
//  DataSourcePatternTemplate
//
//  Created by Alexander Ryakhin on 1/24/22.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private let infoView = ImageInfoView()
    private var model: ImageInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupViews()
        fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoView.snp.makeConstraints { make in
            make.width.height.equalTo(view.snp.width).offset(-20)
            make.centerY.centerX.equalToSuperview()
        }
    }

    private func addSubviews() {
        view.addSubview(infoView)
    }

    private func setupViews() {
        infoView.dataSource = self
        infoView.backgroundColor = .gray.withAlphaComponent(0.1)
        infoView.layer.cornerRadius = 15
    }

    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos/1") else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(ImageInfo.self, from: data)
                self?.model = result
                DispatchQueue.main.async {
                    self?.infoView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController: ImageInfoViewDataSource {
    func imageInfoViewTitleFor(_ infoView: ImageInfoView) -> String? {
        return model?.title
    }

    func imageInfoViewImageURLFor(_ infoView: ImageInfoView) -> URL? {
        return URL(string: model?.url ?? "")
    }
}
