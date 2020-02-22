import XCTest
@testable import turist

class AttractionListPresenterTest: XCTestCase {

    private var router: MockAttractionListRouter!
    private var interactor: MockAttractionListInteractor!
    private var view: MockAttractionListVC!
    private var presenter: AttractionListPresenter!
    
    override func setUp() {
        self.router = MockAttractionListRouter()
        self.interactor = MockAttractionListInteractor()
        self.view = MockAttractionListVC()
        self.presenter = AttractionListPresenter(view: self.view, interactor: self.interactor, router: self.router)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchData() {
        self.presenter.fetchData(isPullToRefresh: true)
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
