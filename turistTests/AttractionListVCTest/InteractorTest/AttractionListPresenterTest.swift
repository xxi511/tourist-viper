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
    
    func testFirstFetchData() {
        self.presenter.fetchData(isPullToRefresh: true)
        XCTAssert(self.view.isLoading)
        XCTAssert(self.interactor.isFetching)
        
        self.presenter.fetchAttractionsSuccess(attractions: FakeData.fakeAttraction())
        XCTAssertFalse(self.view.isLoading)
        XCTAssert(self.view.data.count == 2)
    }
    
    func testFetchDataFailed() {
        self.presenter.fetchData(isPullToRefresh: true)
        XCTAssert(self.view.isLoading)
        XCTAssert(self.interactor.isFetching)
        
        let error = NSError(domain: "test", code: 404, userInfo: ["message": "error occured"])
        self.presenter.fetchAttractionsFailed(error: error)
        XCTAssertFalse(self.view.isLoading)
        XCTAssert(self.router.title == "發生錯誤")
    }

  

}
