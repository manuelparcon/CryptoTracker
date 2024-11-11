//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/11/24.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
