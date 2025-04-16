//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 27/3/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @State private var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environment(viewModel)
        }
    }
}
