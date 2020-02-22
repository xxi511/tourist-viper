//
//  FakeData.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
@testable import Models

struct FakeData {
    static func fakeAttraction() -> [Attraction] {
        let date = Date()
        let doubleValue1 = 1.1
        let doubleValue2 = 2.2
        let fake1 = Attraction(info: "info1", stitle: "stitle1", xpostDate: date, longitude: doubleValue1, REF_WP: doubleValue1, avBegin: date, langinfo: doubleValue1, MRT: "MRT1", SERIAL_NO: "SERIAL1", RowNumber: 1, CAT1: "CAT1", CAT2: "CAT2", MEMO_TIME: "MEMO1", POI: "", files: [], idpt: "", latitude: doubleValue1, xbody: "xbody1", _id: 1, avEnd: date, address: "address1")
        
        let fake2 = Attraction(info: "info2", stitle: "stitle2", xpostDate: date, longitude: doubleValue2, REF_WP: doubleValue2, avBegin: date, langinfo: doubleValue2, MRT: "MRT2", SERIAL_NO: "SERIAL2", RowNumber: 1, CAT1: "CAT2", CAT2: "CAT2", MEMO_TIME: "MEMO2", POI: "", files: [], idpt: "", latitude: doubleValue2, xbody: "xbody2", _id: 1, avEnd: date, address: "address2")
        return [fake1, fake2]
    }
}
