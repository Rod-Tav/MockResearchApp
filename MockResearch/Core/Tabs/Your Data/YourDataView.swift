//
//  YourDataView.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/2/25.
//

import SwiftUI

struct YourDataView: View {
    @Environment(ContentViewModel.self) private var contentViewModel
    
    @State private var showNavBar = false
    @State private var showProfileScreen: Bool = false
    
    @State private var showHealthDataInfo: Bool = false
    @State private var showSensorDataInfo: Bool = false
    @State private var showCommonStudyDataInfo: Bool = false
    @State private var showAdditionalDataInfo: Bool = false
    @State private var showResearchAndPrivacySheet: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                topBar
                
                healthDataAndRecordsSection
                
                sensorAndUsageDataSection
                
                commonStudyDataSection
                
                additionalDataSection
                
                LegalSection(showResearchAndPrivacySheet: $showResearchAndPrivacySheet)
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(.compact)
            .trackScrollWithToolbar(title: "Your Data", showNavBar: $showNavBar)
            .sheet(isPresented: $showHealthDataInfo) {
                infoSheet(title: "Health Data & Records", content: "Learn More About Health Data", isPresented: $showHealthDataInfo)
            }
            .sheet(isPresented: $showSensorDataInfo) {
                infoSheet(title: "Sensor & Usage Data", content: "Learn More About Sensor & Usage Data", isPresented: $showSensorDataInfo)
            }
            .sheet(isPresented: $showCommonStudyDataInfo) {
                infoSheet(title: "Common Study Data", content: "Learn More About Common Study Data", isPresented: $showCommonStudyDataInfo)
            }
            .sheet(isPresented: $showAdditionalDataInfo) {
                infoSheet(title: "Additional Data", content: "Learn More About Additional Data", isPresented: $showAdditionalDataInfo)
            }
        }
    }
}

// MARK: - Top Bar
private extension YourDataView {
    var topBar: some View {
        Section {
            EmptyView()
        } header: {
            HStack {
                Text("Your Data")
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
            .padding(.bottom, 16)
        }
        .listRowInsets(.init())
    }
}

// MARK: - Health Data & Records Section
private extension YourDataView {
    var healthDataAndRecordsSection: some View {
        Section {
            Button("Manage Study Access in Settings") {
                openSettings()
            }
        } header: {
            sectionHeader(
                icon: "heart.fill",
                iconColor: .red,
                title: "Health Data & Records",
                showInfo: $showHealthDataInfo
            )
        }
    }
}

// MARK: - Sensor & Usage Data Section
private extension YourDataView {
    var sensorAndUsageDataSection: some View {
        Section {
            Button("Manage Access in Settings") {
                openSettings()
            }
        } header: {
            sectionHeader(
                icon: "sensor",
                title: "Sensor & Usage Data",
                showInfo: $showSensorDataInfo
            )
        }
    }
}

// MARK: - Common Study Data Section
private extension YourDataView {
    var commonStudyDataSection: some View {
        Section {
            demographicInformationLink
            
            familyHealthHistoryLink
            
            studiesWithAccessLink
        } header: {
            sectionHeader(
                icon: "person.2.fill",
                title: "Common Study Data",
                showInfo: $showCommonStudyDataInfo
            )
        }
    }
    
    var demographicInformationLink: some View {
        NavigationLink {
            Text("If you enroll in a study that needs demographics data, you'll be asked to fill out a survey. You can review that data and which studies have access here.")
                .textCaptionStyle()
                .navigationTitle("Demographic Information")
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Demographic Information")
        }
    }
    
    var familyHealthHistoryLink: some View {
        NavigationLink {
            Text("If you enroll in a study that needs your family medical history, you'll be asked to fill out a survey. You can review that data and which studies have access here.")
                .textCaptionStyle()
                .navigationTitle("Family Health History")
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Family Health History")
        }
    }
    
    var studiesWithAccessLink: some View {
        NavigationLink {
            Text("You are not enrolled in any studies.")
                .textCaptionStyle()
                .navigationTitle("Studies with Access")
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Studies with Access")
        }
    }
}

// MARK: - Additional Data Section
private extension YourDataView {
    var additionalDataSection: some View {
        Section {
            NavigationLink {
                Text("No studies are collecting any analytics data.")
                    .textCaptionStyle()
                    .navigationTitle("Research App Usage")
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                Text("Research App Usage")
            }
            
            Button("Research Profile") {
                showProfileScreen = true
            }
        } header: {
            sectionHeader(
                icon: "chart.bar.xaxis.ascending",
                title: "Additional Data",
                showInfo: $showAdditionalDataInfo
            )
        }
    }
}

// MARK: - Helpers
private extension YourDataView {
    /// Open Settings
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    /// Info Sheet
    func infoSheet(title: String, content: String, isPresented: Binding<Bool>) -> some View {
        NavigationStack {
            Text(content)
                .textTitleStyle()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            isPresented.wrappedValue = false
                        }
                    }
                }
        }
    }
    
    /// Generic Section Header
    func sectionHeader(
        icon: String,
        iconColor: Color = .blue,
        title: String,
        showInfo: Binding<Bool>
    ) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(20)
                .foregroundStyle(iconColor)
            
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                showInfo.wrappedValue = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .font(.title3)
            }
        }
        .textCase(nil)
        .foregroundStyle(Color.primary)
        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 4))
    }
}

private extension View {
    func textCaptionStyle() -> some View {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(24)
            .frameTop()
            .frameLeading()
    }
    
    func textTitleStyle() -> some View {
        self
            .frameLeading()
            .frameTop()
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding()
    }
}

#Preview {
    YourDataView()
        .environment(ContentViewModel())
}
