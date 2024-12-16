//
//  DashboardView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//
import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext: ModelContext

    var currentDate = Calendar.current.dateComponents([.hour, .minute], from: Date())
    var currentTime: String {
        String(format: "%02d:%02d", currentDate.hour ?? 0, currentDate.minute ?? 0)
    }
    var testTime = "12:00"

    @Query(filter: #Predicate<Habit> { task in
        task.routine?.startTime ?? "00:00" <= "18:00"
    }) var tasks: [Habit]

    // sort: [SortDescriptor(\Routine.startTime, comparator: .localizedStandard)]

    var body: some View {
        NavigationStack {
            List(tasks) { task in
                HStack {
                    Text(task.habitName)
                    Spacer()
                    Text(task.routine?.routineName ?? "No routine")
                }
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                .green,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(DataController.previewContainer)
}
