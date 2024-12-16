//
//  RoutineEditorView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/5/24.
//

import SwiftData
import SwiftUI

struct RoutineEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let routine: Routine?

    @State private var name: String = ""

    @Query(filter: #Predicate<Task> { task in
        task.routine?.startTime ?? "00:00" <= "18:00"
    }) var tasks: [Task]

    private var editorTitle: String {
        routine == nil ? "New Routine" : "Edit Routine"
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("Routine Name", text: $name)
                Section(header: ButtonView()) {
                    ForEach(routine?.tasks ?? []) { task in
                        NavigationLink(task.name) {
                            TaskEditorView(task: task)
                        }
                    }
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
            .onAppear {
                if let routine = routine {
                    name = routine.name
                }
            }
        }
    }

    func save() {
        if let routine = routine {
            routine.name = name
        } else {
            let newTimer = Routine(name: name)
            modelContext.insert(newTimer)
        }
    }
}

struct ButtonView: View {
    var body: some View {
        HStack {
            Text("Tasks")
            Spacer()
            Button {
            } label: {
                // NavigationLink(destination: TaskEditorView(task: nil).navigationBarBackButtonHidden(true)) {
                NavigationLink(destination: TaskEditorView(task: nil).navigationBarBackButtonHidden(true)) {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

#Preview("Add Routine") {
    RoutineEditorView(routine: nil)
}
