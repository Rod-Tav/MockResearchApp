//
//  TabHeaderView.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/2/25.
//

import SwiftUI

struct TabHeaderView: View {
    let title: String
    @Binding var showProfileScreen: Bool
    let user: User
    
    var body: some View {
        Section {
            EmptyView()
        } header: {
            HStack {
                Text(title)
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
                    ProfileScreen(user: user)
                }
            }
            .padding(.bottom, 16)
        }
        .listRowInsets(.init())
    }
}

#Preview {
    List {
        Section {
            Text("Content")
        } header: {
            TabHeaderView(
                title: "Tasks",
                showProfileScreen: .constant(false),
                user: User()
            )
        }
    }
}