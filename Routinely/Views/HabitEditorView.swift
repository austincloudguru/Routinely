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
            let newHabit = Habit(habitName: habitName, habitDescription: habitDescription)
            modelContext.insert(newHabit)
        }
    }
}

#Preview {
    HabitEditorView(habit: nil)
        .modelContainer(DataController.previewContainer)
}
