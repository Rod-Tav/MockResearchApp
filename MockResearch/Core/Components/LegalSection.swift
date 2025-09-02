//
//  LegalSection.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/2/25.
//

import SwiftUI

struct LegalSection: View {
    @Binding var showResearchAndPrivacySheet: Bool
    
    // MARK: - Body
    var body: some View {
        Section {
            NavigationLink {
                Text("You are not currently enrolled in any studies that collected consent within this app.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 24)
                    .frameTop()
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
    
    // MARK: - Research Ethics Screen
    private var researchEthicsScreen: some View {
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
        .frameLeading()
        .frameTop()
    }
    
    // MARK: - Research and Privacy Sheet
    private var researchAndPrivacySheet: some View {
        NavigationStack {
            Text("Apple Research App & Privacy")
                .navigationTitle("Apple Research App & Privacy")
                .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    NavigationStack {
        List {
            LegalSection(showResearchAndPrivacySheet: .constant(false))
        }
    }
}
