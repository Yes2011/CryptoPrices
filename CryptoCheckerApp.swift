//
//  CryptoCheckerApp.swift
//  Shared
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import SwiftUI

@main
struct CryptoCheckerApp: App {
    @StateObject private var monitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            HomeView(homeVm: HomeViewModel(coinGecko: CoinGeckoService()))
                .environmentObject(monitor)
        }
    }
}
