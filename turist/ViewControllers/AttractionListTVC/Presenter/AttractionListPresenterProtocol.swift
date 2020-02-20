//
//  AttractionListPresenterProtocol.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import Models

protocol AttractionListPresenterInputProtocol {
    func fetchData(isPullToRefresh: Bool)
}

protocol AttractionListPresenterOutputProtocol {
    func reloadData(data: [Attraction])
    func showLoadingView()
    func dismissLoadingView()
}
