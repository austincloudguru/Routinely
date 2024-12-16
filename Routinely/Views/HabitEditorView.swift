//
//  TaskEditorView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/5/24.
//

import SwiftData
import SwiftUI

struct HabitEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let habit: Habit?
    var routine: Routine?

    @State private var habitName: String = ""
    @State private var habitDescription: String = ""

    private var editorTitle: String {
        habit == nil ? "New Habit" : "Edit Habit"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Habit Name")) {
                    TextField("", text: $habitName)
                }
                Section(header: Text("Description")) {
                    TextField("", text: $habitDescription, axis: .vertical)
                        .lineLimit(5...10)
                }
                if let routine {
                    Text("Routine: \(routine.routineName)")
                } else {
                    Text("Routine: \(habit?.routine?.routineName ?? "")")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }

        .onAppear {
            if let habit = habit {
                habitName = habit.habitName
                habitDescription = habit.habitDescription ?? ""
            }
        }
    }
    func save() {
        if let habit = habit {
            habit.habitName = habitName
            habit.habitDescription = habitDescription
        } else {
            let newHabit = Habit(habitName: habitName, habitDescription: habitDescription, routine: routine)
            modelContext.insert(newHabit)
        }
    }
}

#Preview("New Habit") {
    HabitEditorView(habit: nil)
        .modelContainer(DataController.previewContainer)
}

#Preview("Edit Habit") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Routine.self, configurations: config)
        let habit = Habit(habitName: "Brush Teeth",
                          habitDescription: "Good Oral Hygene",
                          routine: Routine(routineName: "Morning Routine", startTime: "00:00"))
        return HabitEditorView(habit: habit)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
