//
//  Task.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

@Model
class Habit {
    var id: UUID = UUID()
    var habitName: String
    var habitDescription: String?
    var routine: Routine?
    var habitLog: [HabitLog]?

    init(id: UUID = UUID(),
         habitName: String,
         habitDescription: String? = nil,
         routine: Routine? = nil,
         habitLog: [HabitLog]? = nil
    ) {
        self.id = id
        self.habitName = habitName
        self.habitDescription = habitDescription
        self.routine = routine
        self.habitLog = habitLog
    }
}
