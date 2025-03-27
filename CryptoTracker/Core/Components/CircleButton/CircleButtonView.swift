//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 27/3/25.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "heart.fill")
        CircleButtonView(iconName: "heart.fill")
            .colorScheme(.dark)
    }
    
}
