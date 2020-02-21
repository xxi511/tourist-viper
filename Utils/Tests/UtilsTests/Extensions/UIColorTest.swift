import XCTest
@testable import Utils

final class UIColorText: XCTestCase {
    func testHexInitialization() {
        XCTAssertNotNil(UIColor(hexString: "000"))
        XCTAssertNotNil(UIColor(hexString: "#000"))
        
        XCTAssertNotNil(UIColor(hexString: "000000"))
        XCTAssertNotNil(UIColor(hexString: "#000000"))
        
        XCTAssertNotNil(UIColor(hexString: "00000000"))
        XCTAssertNotNil(UIColor(hexString: "#00000000"))
    }
    
    func testNotHexInitialization() {
        XCTAssertNil(UIColor(hexString: "test"))
    }
    

    static var allTests = [
        ("testHexInitialization", testHexInitialization),
        ("testNotHexInitialization", testNotHexInitialization)
    ]
}
