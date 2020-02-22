//
//  MockAttractionListPresenter.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

@testable import turist
@testable import Models

class MockAttractionPresenter: AttractionListPresenterInputProtocol {
    private(set) var error: Error?
    private(set) var attractions: [Attraction]?
    private(set) var isFetchingData: Bool = false
    
    func fetchData(isPullToRefresh: Bool) {
        self.isFetchingData = true
    }
    
    
}

extension MockAttractionPresenter: AttractionListInteractorOutputProtocol {
    func fetchAttractionsSuccess(attractions: [Attraction]) {
        self.attractions = attractions
    }
    
    func fetchAttractionsFailed(error: Error) {
        self.error = error
    }
    
    
}

