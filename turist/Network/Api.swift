//
//  Api.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
enum APIType {
    case Attraction
    
    var url: URL {
        switch self {
        case .Attraction:
            let str = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5"
            return URL(string: str)!
        }
    }
}
