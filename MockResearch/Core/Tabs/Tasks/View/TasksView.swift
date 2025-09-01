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
    @State private var position = ScrollPosition(edge: .top)
    
    @State private var showHealthStudyScreen: Bool = false
    @State private var showProfileScreen: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            tasksList
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Tasks")
                            .font(.headline)
                            .opacity(showNavBar ? 1 : 0)
                    }
                }
        }
    }
    
    // MARK: - Tasks List
    private var tasksList: some View {
        List {
            Section {
                healthStudyCard
                
                tasksCard
            } header: {
                tasksHeader
            }
        }
        .scrollPosition($position)
        .onScrollGeometryChange(for: Bool.self) { g in
            let yFromTop = g.contentOffset.y + g.contentInsets.top
            return yFromTop > 48
        } action: { _, isPastThreshold in
            showNavBar = isPastThreshold
        }
        .listRowSpacing(24)
    }
    
    // MARK: Tasks Header
    private var tasksHeader: some View {
        HStack {
            Text("Tasks")
                .font(.largeTitle.bold())
                .textCase(nil)
                .foregroundStyle(Color.primary)
            
            Spacer()
            
            Button {
                showProfileScreen = true
            } label: {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)
            }
            .sheet(isPresented: $showProfileScreen) {
                ProfileScreen(user: contentViewModel.user)
            }
        }
        .padding(.horizontal, -12)
        .padding(.bottom, 16)
    }
    
    // MARK: Health Study Card
    @ViewBuilder private var healthStudyCard: some View {
        if !hasDismissedHealthStudyCard {
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
    }
    
    // MARK: Tasks Card
    private var tasksCard: some View {
        VStack(alignment: .leading) {
            Text("There are no tasks available.")
                .fontWeight(.semibold)
            
            Text("Go to Studies to enroll in your first study.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TasksView()
        .environment(ContentViewModel())
}
