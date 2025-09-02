//
//  ViewExtensions.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/1/25.
//

import SwiftUI

extension View {
    func onSimultaneousTap(action: @escaping () -> Void) -> some View {
        self
            .simultaneousGesture(TapGesture().onEnded({ action() }))
    }
    
    func frame(_ size: CGFloat) -> some View {
        self
            .frame(width: size, height: size)
    }
}
