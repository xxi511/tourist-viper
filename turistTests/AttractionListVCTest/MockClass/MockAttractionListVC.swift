//
//  MockAttractionListVC.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
@testable import turist
@testable import Models

class MockAttractionListVC: AttractionListPresenterOutputProtocol {
    private var data: [Attraction] = []
    private var isLoading: Bool = false
    
    func reloadData(data: [Attraction]) {
        self.data = data
    }
    
    func showLoadingView() {
        self.isLoading = true
    }
    
    func dismissLoadingView() {
        self.isLoading = false
    }
    
    
}
