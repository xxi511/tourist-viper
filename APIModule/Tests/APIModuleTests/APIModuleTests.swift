import XCTest
@testable import APIModule

final class APIModuleTests: XCTestCase {
    // MARK: test doRequest
    func testUnknowError() {
        let dataTask = MockURLSessionDataTask()
        let unknowError = NetError.UnknowNetError
        let session = MockURLSession(mockDataTask: dataTask, fakeData: nil, error: unknowError)
        let apiManager = ApiManager(session: session)
        
        let request = URLRequest(url: URL(string: "https://google.com")!)
        apiManager.doRequest(request) { (result) in
            switch (result) {
            case .Success(_):
                XCTAssert(false)
            case .Error(let error):
                XCTAssert(error.localizedDescription == unknowError.localizedDescription)
            }
        }
    }
    
    func testBadResponse() {
        let dataTask = MockURLSessionDataTask()
        let badError = NetError.BadResponse(404)
        let session = MockURLSession(mockDataTask: dataTask, fakeData: nil, error: badError)
        let apiManager = ApiManager(session: session)
        
        let request = URLRequest(url: URL(string: "https://google.com")!)
        apiManager.doRequest(request) { (result) in
            switch (result) {
            case .Success(_):
                XCTAssert(false)
            case .Error(let error):
                XCTAssert(error.localizedDescription == badError.localizedDescription)
            }
        }
    }
    
    func testEmptyResponse() {
        let dataTask = MockURLSessionDataTask()
        let emptyError = NetError.EmptyResponse
        let session = MockURLSession(mockDataTask: dataTask, fakeData: nil, error: emptyError)
        let apiManager = ApiManager(session: session)
        
        let request = URLRequest(url: URL(string: "https://google.com")!)
        apiManager.doRequest(request) { (result) in
            switch (result) {
            case .Success(_):
                XCTAssert(false)
            case .Error(let error):
                XCTAssert(error.localizedDescription == emptyError.localizedDescription)
            }
        }
    }
    
    func testOtherError() {
        let dataTask = MockURLSessionDataTask()
        let request = URLRequest(url: URL(string: "https://google.com")!)
        let otherError = NSError(domain: request.url!.absoluteString, code: 500, userInfo: ["message": "Other error"])
        let session = MockURLSession(mockDataTask: dataTask, fakeData: nil, error: otherError)
        let apiManager = ApiManager(session: session)
        
        
        apiManager.doRequest(request) { (result) in
            switch (result) {
            case .Success(_):
                XCTAssert(false)
            case .Error(let error):
                XCTAssert(error.localizedDescription == otherError.localizedDescription)
            }
        }
    }

    func testFetchAttraction() {
        let dataTask = MockURLSessionDataTask()
        let fakeData = FakeData.fakeAttractionResponseData()
        let session = MockURLSession(mockDataTask: dataTask, fakeData: fakeData, error: nil)
        let apiManager = ApiManager(session: session)
        
        apiManager.fetchAttraction { (result) in
            switch (result) {
            case .Success(let data):
                XCTAssert(data.count == 2)
                XCTAssert(data[0].stitle == "新北投溫泉區")
                XCTAssert(data[1].stitle == "大稻埕碼頭")
            case .Error(_):
                XCTAssert(false)
            }
        }
    }
    
    static var allTests = [
        ("testUnknowError", testUnknowError),
        ("testBadResponse", testBadResponse),
        ("testEmptyResponse", testEmptyResponse),
        ("testOtherError", testOtherError),
        ("testFetchAttraction", testFetchAttraction)
    ]
}
