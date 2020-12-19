//
//  SUSTechFlowApp.swift
//  Shared
//
//  Created by Wycer on 2020/11/27.
//

import SwiftUI

@main
struct SUSTechFlowApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(busRoutes: allRoutes)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
