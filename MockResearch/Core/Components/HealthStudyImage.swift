//
//  HealthStudyImage.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import SwiftUI

struct HealthStudyImage: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Image(colorScheme == .dark ? "health-study-dark" : "health-study-light")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    HealthStudyImage()
}
