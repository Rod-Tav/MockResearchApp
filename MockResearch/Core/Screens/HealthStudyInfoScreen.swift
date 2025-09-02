//
//  HealthStudyInfoScreen.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import SwiftUI

struct HealthStudyInfoScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(ContentViewModel.self) private var contentViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                HealthStudyImage()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Apple Health Study")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Brigham and Women's Hospital & Apple")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    
                    ShareLink(
                        item: URL(string: "https://research.apple.com/research-app/Study/apple-health")!,
                        message: Text("Check out the Apple Health Study."),
                        preview: SharePreview("Apple Health Study", image: Image("health-study-light"))
                    ) {
                        Label("Share Study", systemImage: "square.and.arrow.up")
                    }
                    .font(.subheadline)
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    if contentViewModel.user.currentRegion != "United States" {
                        Text("You are currently not eligble to enroll.")
                            .bold()
                            .foregroundStyle(.secondary)
                            .padding(12)
                            .frameLeading()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.regularMaterial)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frameTop()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HealthStudyInfoScreen()
        .environment(ContentViewModel())
}
