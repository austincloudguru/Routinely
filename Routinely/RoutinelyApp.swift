//
//  RoutinelyApp.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//
import SwiftData
import SwiftUI

@main
struct RoutinelyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Routine.self)
    }
}
