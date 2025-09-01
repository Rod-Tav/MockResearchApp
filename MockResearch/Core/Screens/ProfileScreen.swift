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
    @State private var userDidChange: Bool = false
    
    @State private var isEditing: Bool = false
    
    private let originalUser: User
    
    init(user: User) {
        _user = State(initialValue: user)
        originalUser = user
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                formTextField(title: "First Name", field: $user.firstName)
                
                formTextField(title: "Last Name", field: $user.firstName)
                
                
            }
            .listSectionSpacing(0)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                leadingToolbarContent
                
                trailingToolbarContent
            }
        }
    }
    
    // MARK: - Toolbar
    @ToolbarContentBuilder private var leadingToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(isEditing ? "Cancel" : "Done") {
                if isEditing {
                    isEditing = false
                } else {
                    dismiss()
                }
            }
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
    
    @ViewBuilder private func formTextField(title: String, field: Binding<String>) -> some View {
        let text = field.wrappedValue
        
        LabeledContent(title) {
            if isEditing {
                TextField("Required", text: field)
                    .multilineTextAlignment(.trailing)
            } else {
                Text(text.isEmpty ? "Required" : text)
                    .foregroundStyle(text.isEmpty ? .tertiary : .primary)
            }
        }
    }
    
    private func saveEdits() {
        isEditing = false
    }
}

#Preview {
    ProfileScreen(user: User())
}
