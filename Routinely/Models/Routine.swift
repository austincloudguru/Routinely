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
    var name: String
    var desc: String?
    var startTime: String
    var frequency: Frequency
    var tasks: [Task]?

    init(id: UUID = UUID(),
         name: String,
         desc: String? = nil,
         startTime: String = "00:00",
         frequency: Frequency = .daily,
         tasks: [Task]? = nil
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.startTime = startTime
        self.frequency = frequency
        self.tasks = tasks
    }
}
