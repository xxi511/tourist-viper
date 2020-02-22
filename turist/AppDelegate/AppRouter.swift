//
//  AppRouter.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import UIKit
class AppRouter {
    static func initRoute(window: UIWindow) {
        let vc = AttractionListBuilder.createModule()
        let naviVC = UINavigationController(rootViewController: vc)
        window.rootViewController = naviVC
        window.makeKeyAndVisible()
    }
}
