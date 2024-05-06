//
//  ECMOApp.swift
//  ECMO
//
//  Created by Michael Lazar on 4/24/24.
//

import SwiftUI
import SwiftData

@main
struct ECMOApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
			SaveScore.self,
			RespScore.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
