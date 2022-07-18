//
//  iOSCrashlyticsTestApp.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/06/24.
//

import SwiftUI

@main
struct iOSCrashlyticsTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView(stringToIntObject: StringToInt())
        }
    }
}
