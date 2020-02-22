//
//  MockApiManager.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
@testable import APIModule
@testable import Models

class MockAPIManager: APIProtocol {
    
    private let isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func fetchAttraction(completeHandler: @escaping (Result<[Attraction]>) -> Void) {
        if self.isSuccess {
            completeHandler(.Success(FakeData.fakeAttraction()))
        } else {
            let error = NSError(domain: "test", code: 404, userInfo: ["message": "test error"])
            completeHandler(.Error(error))
        }
    }
}
