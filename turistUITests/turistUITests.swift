//
//  turistUITests.swift
//  turistUITests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import XCTest

class turistUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSwipeUp() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let cell1 = app.cells.matching(.cell, identifier: "AttractionCell-1").firstMatch
        XCTAssert(cell1.waitForExistence(timeout: 2.0))
        let title1 = cell1.staticTexts.matching(.staticText, identifier: "AttractionTitle").firstMatch
        XCTAssert(title1.label != "")
        
        let desc1 = cell1.staticTexts.matching(.staticText, identifier: "AttractionDescription").firstMatch
        XCTAssert(desc1.label != "")
        
        app.tables.cells.firstMatch.swipeUp()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
