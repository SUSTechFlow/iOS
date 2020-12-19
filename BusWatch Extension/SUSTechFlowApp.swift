//
//  SUSTechFlowApp.swift
//  BusWatch Extension
//
//  Created by Wycer on 2020/12/7.
//

import SwiftUI

@main
struct SUSTechFlowApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
