//
//  AttractionListInteractor.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
class AttractionListInteractor {
    private let apiManager: ApiProtocol
    private var presenter: AttractionListInteractorOutputProtocol?
    
    init(apiManager: ApiProtocol=ApiManager.shared) {
        self.apiManager = apiManager
    }
    func setPresenter(_ presenter: AttractionListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension AttractionListInteractor: AttractionListInteractorInputProtocol {
    func fetchAttractions() {
        self.apiManager.fetchAttraction { [weak self](result) in
            guard let presenter = self?.presenter else {return}
            switch (result) {
            case .Success(let attrations):
                presenter.fetchAttractionsSuccess(attractions: attrations)
            case .Error(let error):
                presenter.fetchAttractionsFailed(error: error)
            }
        }
    }
}
