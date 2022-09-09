//
//  AppDelegate.swift
//  WFtest
//
//  Created by Егор Беляев on 08.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let controller = ViewController()
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
    
}

