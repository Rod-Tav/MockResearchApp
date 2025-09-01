//
//  ProfileScreen.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var user: User
    @State private var savedUser = User()
    
    @State private var isEditing: Bool = false
    
    @State private var showDataMissingAlert: Bool = false
    @State private var showResearchAndPrivacySheet: Bool = false
    @State private var showEnrollInOtherStudiesSheet: Bool = false
    @State private var showGetHelpSheet: Bool = false
    
    private let initialUser: User
    
    init(user: User) {
        _user = State(initialValue: user)
        _savedUser = State(initialValue: user)
        initialUser = user
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                profileSection
                
                if !isEditing {
                    legalSection
                    
                    notificationsSection
                    
                    enrollInOtherStudiesSection
                    
                    getHelpSection
                    
                    resetStudyParticipationSection
                }
            }
            .listStyle(.insetGrouped)
            .listRowSpacing(0)
            .listSectionSpacing(.compact)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                leadingToolbarContent
                
                principalToolbarContent
                
                trailingToolbarContent
            }
        }
        .environment(\.textCase, nil)
        .alert("Profile Data Missing", isPresented: $showDataMissingAlert) {
            Button("OK") { }
        } message: {
            Text("Please fill out all profile fields.")
        }
    }
}

// MARK: - Toolbar
extension ProfileScreen {
    @ToolbarContentBuilder private var leadingToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(isEditing ? "Cancel" : "Done") {
                if isEditing {
                    user = savedUser
                    isEditing = false
                } else {
                    dismiss()
                }
            }
        }
    }
    
    @ToolbarContentBuilder private var principalToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Profile")
                .font(.headline)
                .foregroundStyle(Color.primary)
        }
    }
    
    @ToolbarContentBuilder private var trailingToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(isEditing ? "Done" : "Edit") {
                if isEditing {
                    saveEdits()
                } else {
                    isEditing = true
                }
            }
        }
    }
}
    
// MARK: - Profile Section
private extension ProfileScreen {
    var profileSection: some View {
        Section {
            TextFormField(
                title: "First Name",
                text: $user.firstName,
                isEditing: isEditing
            )
            
            TextFormField(
                title: "Last Name",
                text: $user.lastName,
                isEditing: isEditing
            )
            
            DateFormField(
                title: "Date of Birth",
                date: $user.dob,
                isEditing: isEditing
            )
            
            TextFormField(
                title: "Email",
                text: $user.email,
                isEditing: isEditing,
                keyboardType: .emailAddress,
                textInputAutocapitalization: .never,
                autocorrectionDisabled: true
            )
            
            TextFormField(
                title: "Phone Number",
                text: $user.phoneNumber,
                isEditing: isEditing,
                keyboardType: .phonePad
            )
            
            RegionPickerFormField(
                title: "Current Region",
                regionCode: $user.currentRegion,
                isEditing: isEditing
            )
        } footer: {
            Text("Your profile information is only shared with studies you're enrolled in for the very rare case that it is necessary to contact you.")
        }
    }
}
    
// MARK: - Legal Section
private extension ProfileScreen {
    var legalSection: some View {
        Section {
            NavigationLink {
                Text("You are not currently enrolled in any studies that collected consent within this app.")
                    .padding(.top, 24)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .navigationTitle("Consent Documents")
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                Text("Consent Documents")
            }
            
            NavigationLink {
                researchEthicsScreen
            } label: {
                Text("About Research Ethics")
            }
            
            NavigationLink {
                Text("Legal Section")
                    .navigationTitle("Legal")
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                Text("Legal")
            }
            
            Button("About Research & Privacy") {
                showResearchAndPrivacySheet = true
            }
            .sheet(isPresented: $showResearchAndPrivacySheet) {
                researchAndPrivacySheet
            }
        }
    }
    
    /// About Research Ethics Screen
    var researchEthicsScreen: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Learn More About Research Ethics Committees.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Apple relies on independent research ethics committees to review and approve the studies in the Research app. Research ethics committees, also called institutional review boards (IRB), evaluate research involving people to ensure the study protects the rights, safety, and privacy of the participants. The committee can approve, reject, modify, or monitor any research it reviews.")
                    .font(.body)
            }
            
            Text("Apple also evaluates the study based on additional privacy and security requirements. If a study is approved by a research ethics committee, Apple, and all the research partners, it can begin.")
                .font(.body)
        }
        .foregroundStyle(Color.primary)
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    /// Apple Research App and Privacy Sheet
    var researchAndPrivacySheet: some View {
        NavigationStack {
            Text("Apple Research App & Privacy")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            showResearchAndPrivacySheet = false
                        }
                    }
                }
        }
    }
}
    
// MARK: - Notifications Section
private extension ProfileScreen {
    var notificationsSection: some View {
        Section {
            NavigationLink {
                Text("Notifications & Invitations")
                    .navigationTitle("Notifications & Invitations")
                    .navigationBarTitleDisplayMode(.inline)
            } label:  {
                Text("Notifications & Invitations")
            }
        }
    }
}
    
// MARK: - Enroll in other studies Section
private extension ProfileScreen {
    var enrollInOtherStudiesSection: some View {
        Section {
            Button("Enroll in other studies") {
                showEnrollInOtherStudiesSheet = true
            }
            .sheet(isPresented: $showEnrollInOtherStudiesSheet) {
                enrollInOtherStudiesSheet
            }
        }
    }
    
    var enrollInOtherStudiesSheet: some View {
        NavigationStack {
            Text("Download Study")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            showEnrollInOtherStudiesSheet = false
                        }
                    }
                }
        }
        .interactiveDismissDisabled()
    }
}
    
// MARK: - Get Help Section
private extension ProfileScreen {
    var getHelpSection: some View {
        Section {
            Button("Get Help") {
                showGetHelpSheet = true
            }
            .sheet(isPresented: $showGetHelpSheet) {
                NavigationStack {
                    Text("Get Help")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Done") {
                                    showGetHelpSheet = false
                                }
                            }
                        }
                }
            }
        }
    }
}
    
// MARK: - Reset Study Participation Section
private extension ProfileScreen {
    var resetStudyParticipationSection: some View {
        Section {
            Button("Reset Study Participation", role: .destructive) {
                // reset study participation
            }
        }
    }
}

// MARK: - Helpers
private extension ProfileScreen {
    func saveEdits() {
        if !initialUser.hasNullField() && user.hasNullField() {
            showDataMissingAlert = true
        } else {
            if user != savedUser {
                savedUser = user
            }
            isEditing = false
        }
    }
}

#Preview {
    ProfileScreen(user: User(firstName: "Rod", lastName: "Tavangar", dob: Date(), email: "email", phoneNumber: "8", currentRegion: "US"))
}
