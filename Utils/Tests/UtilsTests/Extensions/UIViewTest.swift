import XCTest
@testable import Utils

final class UIViewTest: XCTestCase {
    func testSetBorder() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.setBorder(width: 3, color: UIColor.red)
        XCTAssert(view.layer.borderWidth == 3)
    }
    
    func testSetCornerRadius() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.setCornerRadius(8)
        XCTAssert(view.layer.cornerRadius == 8)
        XCTAssert(view.layer.masksToBounds)
    }
    

    static var allTests = [
        ("testSetBorder", testSetBorder),
        ("testSetCornerRadius", testSetCornerRadius)
    ]
}
