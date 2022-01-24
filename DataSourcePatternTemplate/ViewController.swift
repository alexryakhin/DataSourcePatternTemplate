//
//  ViewController.swift
//  DataSourcePatternTemplate
//
//  Created by Alexander Ryakhin on 1/24/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let infoView = ImageInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(infoView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoView.snp.makeConstraints { make in
            make.width.height.equalTo(view.frame.width)
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos/1") else {
            return
        }
    }
}
