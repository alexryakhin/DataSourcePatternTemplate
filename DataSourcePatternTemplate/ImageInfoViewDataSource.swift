//
//  ImageInfoViewDataSource.swift
//  DataSourcePatternTemplate
//
//  Created by Alexander Ryakhin on 1/24/22.
//

import UIKit

protocol ImageInfoViewDataSource: AnyObject {
    // we want this data source to supply data to the ImageInfoView
    func imageInfoViewTitleFor(_ infoView: ImageInfoView) -> String?
    func imageInfoViewImageURLFor(_ infoView: ImageInfoView) -> URL?
}
