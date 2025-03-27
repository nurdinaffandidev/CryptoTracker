//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 27/3/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
