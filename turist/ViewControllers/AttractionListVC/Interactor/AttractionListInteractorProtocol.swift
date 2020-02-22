//
//  File.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import Models

protocol AttractionListInteractorInputProtocol: class {
    func fetchAttractions()
}

protocol AttractionListInteractorOutputProtocol: class {
    func fetchAttractionsSuccess(attractions: [Attraction])
    func fetchAttractionsFailed(error: Error)
}
