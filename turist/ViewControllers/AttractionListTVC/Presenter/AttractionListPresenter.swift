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
    
    private var attractions: [Attraction] = []
    private var offset: Int = 0
    
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
        if (self.attractions.count == 0) {
            interactor.fetchAttractions()
        } else {
            self.sendReloadSignal()
        }
    }
}

extension AttractionListPresenter: AttractionListInteractorOutputProtocol {
    private func sendReloadSignal() {
        self.offset += 10
        let idx = self.attractions.startIndex + self.offset
        DispatchQueue.main.async {
            self.view.reloadData(data: Array(self.attractions[0..<idx]))
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
