//
//  sheApp.swift
//  she
//
//  Created by Kashvi Swami on 8/15/23.
//

import SwiftUI

@main
struct sheApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
