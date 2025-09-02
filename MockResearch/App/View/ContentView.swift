//
//  ContentView.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        TabView {
            Tab("Tasks", systemImage: "checklist") {
                TasksView()
            }
            
            Tab("Studies", systemImage: "list.clipboard") {
                StudiesView()
            }
            
            
            Tab("Your Data", systemImage: "chart.bar") {
                
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
