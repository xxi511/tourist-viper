//
//  Attration.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation

public struct AttrationResult: Codable {
    public var result: Result
    
    public struct Result: Codable {
        var limit: Int
        var offset: Int
        var count: Int
        var sort: String
        public var results: [Attraction]
    }
    
}

public struct Attraction: Codable {
    public var info: String
    public var stitle: String
    public var xpostDate: Date
    public var longitude: Double
    public var REF_WP: Double
    public var avBegin: Date
    public var langinfo: Double
    public var MRT: String
    public var SERIAL_NO: String
    public var RowNumber: Int
    public var CAT1: String
    public var CAT2: String
    public var MEMO_TIME: String
    public var POI: String
    public var files: [URL] // wtf
    public var idpt: String
    public var latitude: Double
    public var xbody: String
    public var _id: Int
    public var avEnd: Date
    public var address: String
    
   
}
//
extension Attraction {
    
    enum CodingKeys: String, CodingKey {
        case info, stitle, xpostDate, longitude, REF_WP, avBegin, langinfo, MRT
        case SERIAL_NO, RowNumber, CAT1, CAT2, MEMO_TIME, POI
        case files="file"
        case idpt, latitude, xbody, _id, avEnd, address
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let infoStr = try values.decodeIfPresent(String.self, forKey: .info)
        info = infoStr ?? ""
        stitle = try values.decode(String.self, forKey: .stitle)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy/MM/dd"

        let xpostDateStr = try values.decode(String.self, forKey: .xpostDate)
        xpostDate = dateFormatter.date(from: xpostDateStr)!

        let longitudeStr = try values.decode(String.self, forKey: .longitude)
        longitude = Double(longitudeStr)!

        let REF_WPStr = try values.decode(String.self, forKey: .REF_WP)
        REF_WP = Double(REF_WPStr)!
        
        let avBeginStr = try values.decode(String.self, forKey: .avBegin)
        avBegin = dateFormatter.date(from: avBeginStr)!

        let langinfoStr = try values.decode(String.self, forKey: .langinfo)
        langinfo = Double(langinfoStr)!
        
        let mrtStr = try values.decodeIfPresent(String.self, forKey: .MRT)
        MRT = mrtStr ?? ""
        SERIAL_NO = try values.decode(String.self, forKey: .SERIAL_NO)
        
        let RowNumberStr = try values.decode(String.self, forKey: .RowNumber)
        RowNumber = Int(RowNumberStr)!
        
        CAT1 = try values.decode(String.self, forKey: .CAT1)
        CAT2 = try values.decode(String.self, forKey: .CAT2)
        
        let memoStr = try values.decodeIfPresent(String.self, forKey: .MEMO_TIME)
        MEMO_TIME = memoStr ?? ""
        
        POI = try values.decode(String.self, forKey: .POI)
        
        // Some files are mp3, remove it
        let filesStr = try values.decode(String.self, forKey: .files)
        files = filesStr.components(separatedBy: "http")
            .filter({$0.count > 0 && ($0.hasSuffix(".jpg") || $0.hasSuffix(".png"))})
            .map({url in
                // only https can get image
                let append = url.hasPrefix("s") ? "http": "https"
                return append + url
            })
            .map({URL(string: $0)!})
        
        idpt = try values.decode(String.self, forKey: .idpt)
        
        let latitudeStr = try values.decode(String.self, forKey: .latitude)
        latitude = Double(latitudeStr)!
        
        xbody = try values.decode(String.self, forKey: .xbody)
        _id = try values.decode(Int.self, forKey: ._id)
        
        let avEndStr = try values.decode(String.self, forKey: .avEnd)
        avEnd = dateFormatter.date(from: avEndStr)!
        
        address = try values.decode(String.self, forKey: .address)
    }

}
