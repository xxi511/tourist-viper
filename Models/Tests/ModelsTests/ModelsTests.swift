import XCTest
@testable import Models

final class ModelsTests: XCTestCase {
    func fakeAttractionData() -> Data {
        return Data("""
        {
        "info": "捷運站名：雙連站，轉乘紅33(固定班次)於大稻埕碼頭站下車。公車：9、206、274、641、669、704至大稻埕碼頭站及255、518、539至民生西路口站，再沿民生西路底方向步行約10分鐘抵達。 開車：沿著環河北路依大稻埕碼頭入口指引便可抵達。",
        "stitle": "大稻埕碼頭",
        "xpostDate": "2015/12/09",
        "longitude": "121.508274",
        "REF_WP": "10",
        "avBegin": "2008/08/02",
        "langinfo": "10",
        "MRT": "雙連",
        "SERIAL_NO": "2011051800000007",
        "RowNumber": "2",
        "CAT1": "景點",
        "CAT2": "藍色公路",
        "MEMO_TIME": "平常日以團體預約包船為主，例假日行駛固定航次，請洽詢各船公司。\\n強烈季風、漲退潮水位差影響航行及靠泊安全，當日實際航班得由現場公告或網站預告調整。",
        "POI": "Y",
        "file": "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000340.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D906/E6/F186/809f30db-7079-421f-a625-7baa8ec21874.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000341.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D878/E420/F173/04765739-d40f-4d13-b271-8d5f9e5f44bd.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000342.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D20/E983/F199/866b5059-8fd7-4719-964c-51d2f78675d5.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D546/E538/F353/ed2464d1-bc28-4790-96cd-5216db2c14f5.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D814/E111/F733/aed9d34d-890c-49fd-83ca-f76f38e4b94b.jpghttp://www.travel.taipei/streams/sceneadmin/video/100C1.mp3",
        "idpt": "臺北旅遊網",
        "latitude": "25.056847",
        "xbody": "大稻埕原是平埔族的居住地，因萬華（艋舺）同安人發生激烈的械鬥，造成族人移至大稻埕定居，開始大稻埕淡水河旁商店和房屋的興建，淡水港開放後，大稻埕在劉銘傳的治理下成為臺北城最繁華的物資集散中心，當中以茶葉、布料為主要貿易交易，當時的延平北路及貴德街一帶便是商業活動的重心，也讓大稻埕早年的歷史多采多姿、令人回味。 ",
        "_id": 2,
        "avEnd": "2015/12/09",
        "address": "臺北市  大同區環河北路一段"
        }
        """.utf8)
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    func testCodable() {
        let fake = fakeAttractionData()
        let attraction = try! JSONDecoder().decode(Attraction.self, from: fake)
        XCTAssertNotNil(attraction)
        
        XCTAssert(attraction.stitle == "大稻埕碼頭")
        
        let xbody = "大稻埕原是平埔族的居住地，因萬華（艋舺）同安人發生激烈的械鬥，造成族人移至大稻埕定居，開始大稻埕淡水河旁商店和房屋的興建，淡水港開放後，大稻埕在劉銘傳的治理下成為臺北城最繁華的物資集散中心，當中以茶葉、布料為主要貿易交易，當時的延平北路及貴德街一帶便是商業活動的重心，也讓大稻埕早年的歷史多采多姿、令人回味。 "
        XCTAssert(attraction.xbody == xbody)
        
        XCTAssert(attraction._id == 2)
        
        let dateStr = dateToString(date: attraction.avEnd)
        XCTAssert(dateStr == "2015/12/09")
        
        let fileUrl = "https://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000340.jpg"
        XCTAssert(attraction.files[0].absoluteString == fileUrl)
        XCTAssert(attraction.files.count == 8)
    }

    static var allTests = [
        ("testCodable", testCodable),
    ]
}
