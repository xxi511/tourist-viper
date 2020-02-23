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
    
    private weak var view: AttractionListPresenterOutputProtocol?
    private var interactor: AttractionListInteractorInputProtocol?
    private var router: AttractionListRouterProtocol?
    
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
        
        view?.showLoadingView()
        if (isPullToRefresh) {
            self.offset = 0
            self.attractions = []
            interactor?.fetchAttractions()
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
        defer {
            self.view?.dismissLoadingView()
            self.isFetchingData = false
        }
        
        guard self.offset != self.attractions.count else {
            router?.showAlert(title: nil, message: "沒有更多資料了")
            return
        }
        
        let start = self.offset
        self.offset = min(self.offset + updateNum, self.attractions.count)
        
        if (self.offset == self.updateNum) {
            self.view?.reloadData(data: Array(self.attractions[0..<self.offset]))
        } else {
            self.view?.insertData(data: Array(self.attractions[start..<self.offset]))
        }
    }
    
    func fetchAttractionsSuccess(attractions: [Attraction]) {
        self.attractions = attractions
        self.sendReloadSignal()
    }
    
    func fetchAttractionsFailed(error: Error) {
        router?.showAlert(title: "發生錯誤", message: error.localizedDescription)
        self.view?.dismissLoadingView()
    }
    
    
}
