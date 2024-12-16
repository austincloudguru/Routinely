//
//  ContentView.swift
//  Routinely
//
//  Created by Mark Honomichl on 12/2/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query(sort: [SortDescriptor(\Routine.routineName, comparator: .localizedStandard)]) var routines: [Routine]

    var body: some View {
        TabView {
                   Group {
                       DashboardView()
                           .tabItem {
                               Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                                   .padding(4)
                           }
                       RoutineView()
                           .tabItem {
                               Image(systemName: "line.3.horizontal")
                           }
                       Text("Reports")
                           .tabItem {
                               Image(systemName: "chart.bar")
                                   .backgroundStyle(Color.blue)
                           }
                   }
                    .toolbarBackground(.green, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
               }
    }
}

#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}
