//
//  Task.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

@Model
class Task {
    var id: UUID = UUID()
    var name: String
    var taskDescription: String?
    var routine: Routine?
    var taskLog: [TaskLog]?

    init(id: UUID = UUID(),
         name: String,
         taskDescription: String? = nil,
         routine: Routine? = nil,
         taskLog: [TaskLog]? = nil
    ) {
        self.id = id
        self.name = name
        self.taskDescription = taskDescription
        self.routine = routine
        self.taskLog = taskLog
    }
}
