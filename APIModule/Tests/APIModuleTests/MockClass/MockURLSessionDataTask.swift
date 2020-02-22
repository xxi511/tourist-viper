//
//  File.swift
//  
//
//  Created by 陳建佑 on 2020/2/22.
//

@testable import APIModule

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private(set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
