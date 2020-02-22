//
//  File.swift
//  
//
//  Created by 陳建佑 on 2020/2/22.
//

import Foundation
@testable import APIModule

class MockURLSession: URLSessionProtocol {
    private let error: Error?
    private let mockDataTask: MockURLSessionDataTask
    private let fakeData: Data?
    
    init(mockDataTask: MockURLSessionDataTask, fakeData: Data?=nil, error: Error?=nil) {
        self.error = error
        self.mockDataTask = mockDataTask
        self.fakeData = fakeData
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        guard self.error != nil else {
            let response = self.mockHttpURLResponse(request: request, statusCode: 200)
            completionHandler(self.fakeData!, response, nil)
            return self.mockDataTask
        }
        
        guard let _error = self.error as? NetError else {
            completionHandler(nil, nil, self.error!)
            return self.mockDataTask
        }
        
        switch _error {
        case .UnknowNetError:
            completionHandler(nil, nil, nil)
        case .BadResponse(let code):
            let response = self.mockHttpURLResponse(request: request, statusCode: code)
            completionHandler(nil, response, nil)
        case .EmptyResponse:
            let response = self.mockHttpURLResponse(request: request, statusCode: 200)
            completionHandler(nil, response, nil)
        }
        return self.mockDataTask
    }
}

// MARK: Private
extension MockURLSession {
    
    private func mockHttpURLResponse(request: URLRequest, statusCode: Int) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}
