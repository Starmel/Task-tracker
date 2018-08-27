//
//  AppDelegate.swift
//  Task-tracker
//
//  Created by admin on 23.08.2018.
//  Copyright © 2018 Slava Kornienko. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppDependencies.build()
        return true
    }
}

