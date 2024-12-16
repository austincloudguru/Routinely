//
//  TaskLog.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

@Model
class TaskLog {
    var id: UUID
    var logDate: Date
    var isCompleted: Bool
    var task: Task

    init(id: UUID, logDate: Date, isCompleted: Bool, task: Task) {
        self.id = id
        self.logDate = logDate
        self.isCompleted = isCompleted
        self.task = task
    }
}
