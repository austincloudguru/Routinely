//
//  Routine.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//

import Foundation
import SwiftData

enum Frequency: String, Codable {
    case daily
    case weekday
    case weekend
    case monthly
    case yearly
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

@Model
class Routine {
    var id: UUID
    var routineName: String
    var routineDescription: String?
    var startTime: String
    var frequency: Frequency
    var habits: [Habit]?

    init(id: UUID = UUID(),
         routineName: String,
         routineDescription: String? = nil,
         startTime: String = "00:00",
         frequency: Frequency = .daily,
         habits: [Habit]? = nil
    ) {
        self.id = id
        self.routineName = routineName
        self.routineDescription = routineDescription
        self.startTime = startTime
        self.frequency = frequency
        self.habits = habits
    }
}
