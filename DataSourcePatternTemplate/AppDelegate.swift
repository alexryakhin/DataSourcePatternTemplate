//
//  AppDelegate.swift
//  DataSourcePatternTemplate
//
//  Created by Alexander Ryakhin on 1/24/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainController = ViewController() as UIViewController
        self.window?.rootViewController = mainController
        self.window?.makeKeyAndVisible()
        return true
    }
}
