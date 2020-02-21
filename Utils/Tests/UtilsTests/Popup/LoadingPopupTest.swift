import XCTest
@testable import Utils

final class LoadingPopupTest: XCTestCase {
    
    func testLoadingPopup() {
        let vc = UIViewController()
        LoadingPopup.show(in: vc)
        var loadingPops = vc.view.subviews.filter {$0 is LoadingPopup}
        XCTAssert(loadingPops.count == 1)
        
        LoadingPopup.remove(from: vc)
        loadingPops = vc.view.subviews.filter {$0 is LoadingPopup}
        XCTAssert(loadingPops.count == 0)
    }

    static var allTests = [
        ("testLoadingPopup", testLoadingPopup)
    ]
}
