//
//  DataController.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Routine.self, configurations: config)

            let morningRoutine = Routine(name: "Morning",
                                         startTime: "06:00",
                                         tasks: [Task(name: "Brush Teeth"),
                                                 Task(name: "Take Pills")])
            container.mainContext.insert(morningRoutine)

            let startupRoutine = Routine(name: "Startup",
                                         startTime: "09:00",
                                         tasks: [Task(name: "Check Email"),
                                                 Task(name: "Review Tasks")])
            container.mainContext.insert(startupRoutine)

            let shutdownRoutine = Routine(name: "Shutdown",
                                         startTime: "15:00",
                                         tasks: [Task(name: "Check Email"),
                                                 Task(name: "Review Tasks")])
            container.mainContext.insert(shutdownRoutine)

            let eveningRoutine = Routine(name: "Evening",
                                         startTime: "21:00",
                                         tasks: [Task(name: "Brush Teeth"),
                                                 Task(name: "Take Pills")])
            container.mainContext.insert(eveningRoutine)

//            for myRoutine in myRoutines {
//                let routine = Routine(name: myRoutine,
//                                      startTime: "06:00",
//                                      endTime: "18:00",
//                                      tasks: [Task(name: "Brush Teeth"),
//                                              Task(name: "Take Pills")])
//                container.mainContext.insert(routine)
//            }
//            for num in 1...9 {
//                let routine = Routine(name: "Example Routine \(num)")
//                container.mainContext.insert(routine)
//            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
