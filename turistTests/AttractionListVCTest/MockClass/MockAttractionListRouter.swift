//
//  MockAttractionListRouter.swift
//  turistTests
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import UIKit
@testable import turist

class MockAttractionListRouter: AttractionListRouterProtocol {
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    func showAlert(title: String?, message: String?) {
        
    }
    
    
}
