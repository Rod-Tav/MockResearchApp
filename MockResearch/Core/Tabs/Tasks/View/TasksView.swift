//
//  TasksView.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import SwiftUI

struct TasksView: View {
    @AppStorage("hasDismissedHealthStudyCard") private var hasDismissedHealthStudyCard: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Environment(ContentViewModel.self) private var contentViewModel
    
    @State private var showNavBar = false
    @State private var showHealthStudyScreen: Bool = false
    @State private var showProfileScreen: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                TabHeaderView(
                    title: "Tasks",
                    showProfileScreen: $showProfileScreen,
                    user: contentViewModel.user
                )
                
                if !hasDismissedHealthStudyCard {
                    healthStudyCard
                }
                
                tasksCard
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(.compact)
            .trackScrollWithToolbar(title: "Tasks", showNavBar: $showNavBar)
        }
    }
    
    // MARK: Health Study Card
    private var healthStudyCard: some View {
        Section {
            VStack(alignment: .leading, spacing: 12) {
                HealthStudyImage()
                    .clipShape(.rect(cornerRadius: 8))
                    .overlay(alignment: .topTrailing) {
                        Button {
                            hasDismissedHealthStudyCard = true
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.tertiary)
                        }
                        .buttonStyle(.plain)
                        .padding(16)
                    }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Apple Health Study")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Play a part in research designed to inspire the future of health and technology.")
                        .foregroundStyle(.secondary)
                    
                    Button("Learn More") {
                        showHealthStudyScreen = true
                    }
                    .font(.callout)
                    .sheet(isPresented: $showHealthStudyScreen) {
                        HealthStudyInfoScreen()
                            .environment(contentViewModel)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
        }
        .listSectionSpacing(24)
    }
    
    // MARK: Tasks Card
    private var tasksCard: some View {
        Section {
            VStack(alignment: .leading) {
                Text("There are no tasks available.")
                    .fontWeight(.semibold)
                
                Text("Go to Studies to enroll in your first study.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    TasksView()
        .environment(ContentViewModel())
}
