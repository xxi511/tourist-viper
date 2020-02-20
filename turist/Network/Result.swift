//
//  Result.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
enum Result<T> {
    case Success(T)
    case Error(Error)
}
