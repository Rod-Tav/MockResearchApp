//
//  ScrollTrackingModifier.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/2/25.
//

import SwiftUI

struct ScrollTrackingModifier: ViewModifier {
    let title: String
    @Binding var showNavBar: Bool
    @State private var position = ScrollPosition(edge: .top)
    
    func body(content: Content) -> some View {
        content
            .scrollPosition($position)
            .onScrollGeometryChange(for: Bool.self) { g in
                let yFromTop = g.contentOffset.y + g.contentInsets.top
                return yFromTop > 48
            } action: { _, isPastThreshold in
                showNavBar = isPastThreshold
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .opacity(showNavBar ? 1 : 0)
                }
            }
    }
}

extension View {
    /// Tracks scroll position and shows/hides navigation bar title based on scroll offset
    func trackScrollWithToolbar(title: String, showNavBar: Binding<Bool>) -> some View {
        modifier(ScrollTrackingModifier(title: title, showNavBar: showNavBar))
    }
}
