//
//  TaskEditorView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/5/24.
//

import SwiftData
import SwiftUI

struct TaskEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let task: Task?

    @State private var name: String = ""
    @State private var taskDescription: String = ""

    private var editorTitle: String {
        task == nil ? "New Habit" : "Edit Habit"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Habit Name")) {
                    TextField("", text: $name)
                }
                Section(header: Text("Description")) {
                    TextField("", text: $taskDescription, axis: .vertical)
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
            if let task = task {
                name = task.name
                taskDescription = task.taskDescription ?? ""
            }
        }
    }
    func save() {
        if let habit = task {
            habit.name = name
            habit.taskDescription = taskDescription
        } else {
            let newHabit = Task(name: name, taskDescription: taskDescription)
            modelContext.insert(newHabit)
        }
    }
}

#Preview {
    TaskEditorView(task: nil)
        .modelContainer(DataController.previewContainer)
}
