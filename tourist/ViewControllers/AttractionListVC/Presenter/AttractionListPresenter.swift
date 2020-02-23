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
        if (isPullToRefresh || self.attractions.count == 0) {
            self.offset = 0
            self.attractions = []
            interactor?.fetchAttractions()
        } else {
            // Simulate real http request delay
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.sendReloadSignal(isPullToRefresh: false)
            }
        }
    }
}

extension AttractionListPresenter: AttractionListInteractorOutputProtocol {
    private func sendReloadSignal(isPullToRefresh: Bool) {
        defer {
            self.view?.dismissLoadingView()
            self.isFetchingData = false
        }

        let start = self.offset
        self.offset = min(self.offset + updateNum, self.attractions.count)
        
        if (isPullToRefresh) {
            self.view?.reloadData(data: Array(self.attractions[0..<self.offset]))
        } else {
            self.view?.insertData(data: Array(self.attractions[start..<self.offset]))
        }
        
        if self.offset == self.attractions.count {
            router?.showAlert(title: nil, message: "沒有更多資料了")
        }
    }
    
    func fetchAttractionsSuccess(attractions: [Attraction]) {
        self.attractions = attractions
        self.sendReloadSignal(isPullToRefresh: true)
    }
    
    func fetchAttractionsFailed(error: Error) {
        self.view?.dismissLoadingView()
        self.view?.reloadData(data: [])
        self.isFetchingData = false
        router?.showAlert(title: "發生錯誤", message: error.localizedDescription)
    }
    
    
}
