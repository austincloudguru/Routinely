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

    @State private var routineName: String = ""

    @Query(filter: #Predicate<Habit> { task in
        task.routine?.startTime ?? "00:00" <= "18:00"
    }) var tasks: [Habit]

    private var editorTitle: String {
        routine == nil ? "New Routine" : "Edit Routine"
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Routine Name", text: $routineName)
                if let routine {
                Section(header: ButtonView(routine: routine)) {
                    ForEach(routine.habits ?? []) { habit in
                        NavigationLink(habit.habitName) {
                            HabitEditorView(habit: habit).navigationBarBackButtonHidden(true)
                        }
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
                            // dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let routine = routine {
                    routineName = routine.routineName
                }
            }
        }
    }

    func save() {
        if let routine = routine {
            routine.routineName = routineName
        } else {
            let newRoutine = Routine(routineName: routineName)
            modelContext.insert(newRoutine)
        }
    }
}

struct ButtonView: View {
    let routine: Routine
    var body: some View {
        HStack {
            Text("Habits")
            Spacer()
            Button {
            } label: {
                NavigationLink(destination: HabitEditorView(habit: nil,
                                                            routine: routine)
                    .navigationBarBackButtonHidden(true)) {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

#Preview("Add Routine") {
    RoutineEditorView(routine: nil)
}

#Preview("Edit Routine") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Routine.self, configurations: config)
        let routine = Routine(routineName: "Clean",
                              startTime: "00:00",
                              habits: [Habit(habitName: "Brush Teeth"),
                                       Habit(habitName: "Take Pills")])
        return RoutineEditorView(routine: routine)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
