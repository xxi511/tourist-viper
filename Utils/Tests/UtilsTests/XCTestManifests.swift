import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UIColorTest.allTests),
        testCase(UIViewTest.allTests)
    ]
}
#endif
