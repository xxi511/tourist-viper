//
//  AppDelegate.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupNavigationBar()
        
        if window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        AppRouter.initRoute(window: self.window!)
        return true
    }

}

// MARK: Private
extension AppDelegate {
    func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "3fc1ee")!
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor.white]
    }
}
