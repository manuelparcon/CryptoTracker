//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/11/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0) : .none, value: animate) // Animate only in 1 direction (when animate turns from false to true)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
