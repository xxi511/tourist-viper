//
//  File.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import Models

protocol AttractionListInteractorInputProtocol {
    func fetchAttractions()
}

protocol AttractionListInteractorOutputProtocol {
    func fetchAttractionsSuccess(attractions: [Attraction])
    func fetchAttractionsFailed(error: Error)
}
