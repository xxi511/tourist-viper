//
//  AttractionListPresenter.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import Models

class AttractionListPresenter {
    
    private let view: AttractionListPresenterOutputProtocol
    private let interactor: AttractionListInteractorInputProtocol
    private let router: AttractionListRouterProtocol
    
    private var updateNum: Int = 10
    private var attractions: [Attraction] = []
    private var offset: Int = 0
    private var isFetchingData: Bool = false
    
    init(view: AttractionListPresenterOutputProtocol,
         interactor: AttractionListInteractorInputProtocol,
         router: AttractionListRouterProtocol) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AttractionListPresenter: AttractionListPresenterInputProtocol {
    func fetchData(isPullToRefresh: Bool) {
        guard !self.isFetchingData else {return}
        self.isFetchingData = true
        
        view.showLoadingView()
        if (self.attractions.count == 0) {
            interactor.fetchAttractions()
        } else {
            // Simulate real http request delay
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.sendReloadSignal()
            }
        }
    }
}

extension AttractionListPresenter: AttractionListInteractorOutputProtocol {
    private func sendReloadSignal() {
        self.offset = min(self.offset + updateNum, self.attractions.count)
        let idx = self.attractions.startIndex + self.offset
        DispatchQueue.main.async {
            self.view.reloadData(data: Array(self.attractions[0..<idx]))
            self.view.dismissLoadingView()
            self.isFetchingData = false
        }
        
    }
    
    func fetchAttractionsSuccess(attractions: [Attraction]) {
        self.attractions = attractions
        self.sendReloadSignal()
    }
    
    func fetchAttractionsFailed(error: Error) {
        router.showErrorAlert(error: error)
    }
    
    
}
