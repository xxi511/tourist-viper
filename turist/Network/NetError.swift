//
//  NetWorkError.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation

enum NetError: Error {
    case UnknowNetError
    case BadResponse(Int)
    case EmptyResponse
}

extension NetError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .UnknowNetError:
            return NSLocalizedString("Unknow net error", comment: "Unknow net error")
        case .BadResponse(let status):
            return NSLocalizedString("Get bad response status code: \(status)", comment: "Bad response")
        case .EmptyResponse:
            return NSLocalizedString("Get empty response", comment: "Empty response")
        }
    }
}
