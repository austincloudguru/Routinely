//
//  RoutineView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//
import SwiftData
import SwiftUI

struct RoutineView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query(sort: [SortDescriptor(\Routine.startTime, comparator: .localizedStandard)]) var routines: [Routine]

    var body: some View {
        NavigationStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink(routine.name) {
                        RoutineEditorView(routine: routine)
                    }
                }
            }
            .toolbar {
                ItemsToolbar()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                .green,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
     }
}

struct ItemsToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
            } label: {
                NavigationLink(destination: RoutineEditorView(routine: nil)) {
                    Image(systemName: "plus")
                }
            }
        }
        ToolbarItem(placement: .principal) {
            Text("Routines")
        }
    }
}

#Preview {
    RoutineView()
        .modelContainer(DataController.previewContainer)
}
