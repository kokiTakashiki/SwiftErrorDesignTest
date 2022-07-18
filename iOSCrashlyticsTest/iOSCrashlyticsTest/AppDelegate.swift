//
//  AppDelegate.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/06/24.
//

import SwiftUI
import FirebaseCore

extension iOSCrashlyticsTestApp {
    class AppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
        var orientationLock = UIInterfaceOrientationMask.portrait
        func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
        }
    }
}
