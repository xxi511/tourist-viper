//
//  ApiManager.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import Models

public class ApiManager: ApiProtocol {
    public static let shared: ApiManager = ApiManager()
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol=URLSession.shared) {
        self.session = session
    }
    
    public func fetchAttraction(completeHandler: @escaping (Result<[Attraction]>) -> Void) {
        let req = URLRequest(url: APIType.Attraction.url)
        self.doRequest(req) { (result) in
            switch result {
            case .Success(let data):
                let res = try! JSONDecoder().decode(AttrationResult.self, from: data)
                completeHandler(.Success(res.result.results))
            case .Error(let error):
                completeHandler(.Error(error))
            }
        }
    }
}

extension ApiManager {
    internal func doRequest(_ request: URLRequest, completeHandler: @escaping (Result<Data>) -> Void) {
        let task = self.session.dataTask(with: request) { (data, urlResponse, error) in
            guard error == nil else {
                completeHandler(.Error(error!))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completeHandler(.Error(NetError.UnknowNetError))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                let code = httpResponse.statusCode
                completeHandler(.Error(NetError.BadResponse(code)))
                return
            }
            
            guard let _data = data else {
                completeHandler(.Error(NetError.EmptyResponse))
                return
            }
            completeHandler(.Success(_data))
        }
        task.resume()
    }
}
