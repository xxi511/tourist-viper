//
//  InteractorTest.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import XCTest
@testable import turist
@testable import Models

class AttractionListInteractorTest: XCTestCase {
    private var presenter: MockAttractionPresenter!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = MockAttractionPresenter()
    }
    
    func testFailedCase() {
        let mockAPIManager = MockAPIManager(isSuccess: false)
        let interactor = AttractionListInteractor(apiManager: mockAPIManager)
        interactor.configure(presenter: presenter)
        
        interactor.fetchAttractions()
        XCTAssertNotNil(self.presenter.error)
    }

    func testSuccessCase() {
        let mockAPIManager = MockAPIManager(isSuccess: true)
        let interactor = AttractionListInteractor(apiManager: mockAPIManager)
        interactor.configure(presenter: presenter)
        
        interactor.fetchAttractions()
        XCTAssertNotNil(self.presenter.attractions)
        XCTAssert(self.presenter.attractions!.count == 2)
        XCTAssert(self.presenter.attractions![0].info == "info1")
    }

}
