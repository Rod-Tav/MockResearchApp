//
//  StudiesView.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/1/25.
//

import SwiftUI

struct StudiesView: View {
    @Environment(ContentViewModel.self) private var contentViewModel
    
    @State private var showHealthStudyScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                appleHealthStudySection
                
                openStudiesSection
                
                previousStudiesSection
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(12)
            .safeAreaPadding(.bottom, 24)
            .navigationTitle("Studies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Apple Health Study Section
private extension StudiesView {
    var appleHealthStudySection: some View {
        Section {
            HealthStudyImage(contentMode: .fill)
                .frame(height: 200)
                .listRowInsets(.init())
            
            appleHealthStudyCard
        }
    }
    
    var appleHealthStudyCard: some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                Text("Join the")
                    .font(.title3.bold())
                
                Text("Apple Health Study")
                    .font(.largeTitle.bold())
            }
            
            VStack(spacing: 8) {
                Text("Play a part in research designed to inspire the future of health and technology.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Text("Brigham and Women's Hospital & Apple")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Button {
                showHealthStudyScreen = true
            } label: {
                Text("Learn More")
                    .bold()
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showHealthStudyScreen) {
                HealthStudyInfoScreen()
                    .environment(contentViewModel)
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Open Studies Section
private extension StudiesView {
    @ViewBuilder var openStudiesSection: some View {
        Section {
            womensHealthStudyCard
        } header: {
            Text("Open Studies")
                .font(.title2.bold())
                .foregroundStyle(Color.primary)
                .textCase(nil)
        }
        
        Section {
            hearingStudyCard
        }
    }
    
    var womensHealthStudyCard: some View {
        studyCard(
            imageName: "womens-health-study",
            title: "Apple Women's Health Study",
            description: "Participate in the first long-term research study of this scale and scope, that aims to advance the understanding of menstrual cycles and their relationship to various health conditions including infertility and menopause.",
            caption: "Harvard T.H. Chan School of Public Health, National Institute of Environmental Health Sciences & Apple"
        )
    }
    
    var hearingStudyCard: some View {
        studyCard(
            imageName: "apple-hearing-study",
            title: "Apple Hearing Study",
            description: "Contribute to a first of its kind research study to collect sound exposure data over time and advance the understanding of how sound levels can impact your hearing.",
            caption: "University of Michigan, World Health Organization & Apple"
        )
    }
}

// MARK: - Previous Studies Section
private extension StudiesView {
    @ViewBuilder var previousStudiesSection: some View {
        Section {
            previousStudyRow(
                iconName: "bolt.heart.fill",
                iconColors: [.orange, .red],
                title: "Apple Heart & Movement Study",
                endDate: "3/1/2025"
            )
        } header: {
            Text("Previous Studies")
                .font(.title2.bold())
                .foregroundStyle(Color.primary)
                .textCase(nil)
        }
        
        Section {
            previousStudyRow(
                iconName: "heart.text.square.fill",
                iconColors: [.orange, .pink],
                title: "Apple Heart Study",
                endDate: "9/14/2018"
            )
        }
    }
}


// MARK: - Components
private extension StudiesView {
    /// Generic study card
    func studyCard(
        imageName: String,
        title: String,
        description: String,
        caption: String
    ) -> some View {
        VStack(spacing: 4) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2.bold())
                
                Text(description)
                    .font(.body)
                
                Text(caption)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
        }
        .listRowInsets(.init())
    }
    
    /// Generic previous study row
    func previousStudyRow(
        iconName: String,
        iconColors: [Color],
        title: String,
        endDate: String
    ) -> some View {
        HStack(spacing: 12) {
            LinearGradient(
                colors: iconColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .mask(
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(40)
            )
            .frame(50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text("Ended on \(endDate)")
                    .font(.footnote.bold())
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    StudiesView()
        .environment(ContentViewModel())
}
