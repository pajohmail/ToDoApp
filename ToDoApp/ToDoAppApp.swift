//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Per-Arne Johansson on 2024-11-11.
//

import SwiftUI
import SwiftData

/// The main entry point for the ToDoApp, configuring the SwiftData model container and launching the app's primary view.
@main
struct ToDoAppApp: App {
    /// A shared instance of `ModelContainer` configured to store data persistently.
    ///
    /// - The schema includes the `Item` model, which defines the data structure for the to-do items.
    /// - The `ModelConfiguration` is set to store data persistently (not in-memory).
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        // Attempt to initialize the model container with the specified schema and configuration.
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Fatal error if the model container cannot be created, as the app depends on this data layer.
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        // Define the main app window scene with ContentView as the root view.
        WindowGroup {
            ContentView()
        }
        // Provide the shared `ModelContainer` to the app's environment for data persistence.
        .modelContainer(sharedModelContainer)
    }
}

