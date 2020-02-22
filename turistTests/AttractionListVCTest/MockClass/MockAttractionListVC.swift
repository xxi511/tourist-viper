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
    
    private(set) var data: [Attraction] = []
    private(set) var isLoading: Bool = false
    
    func reloadData(data: [Attraction]) {
        self.data = data
    }
    
    func insertData(data: [Attraction]) {
        self.data.append(contentsOf: data)
    }
    
    func showLoadingView() {
        self.isLoading = true
    }
    
    func dismissLoadingView() {
        self.isLoading = false
    }
    
    
}
