//
//  TaskLog.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

@Model
class HabitLog {
    var id: UUID
    var logDate: Date
    var isCompleted: Bool
    var habit: Habit

    init(id: UUID, logDate: Date, isCompleted: Bool, task: Habit) {
        self.id = id
        self.logDate = logDate
        self.isCompleted = isCompleted
        self.habit = task
    }
}
