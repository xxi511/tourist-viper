import XCTest
@testable import APIModule

final class APIModuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(APIModule().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
