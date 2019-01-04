//
//  AppDelegate.swift
//  audio-recognizer
//
//  Created by Leandro Bartsch Thá on 04/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let shared = {
        return UIApplication.shared.delegate
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

