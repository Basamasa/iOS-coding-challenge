//
//  Payback_assignmentApp.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import SwiftUI

@main
struct Payback_assignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewContext: persistenceController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
