//
//  HomeViewModel.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import Foundation
import SwiftUI

@MainActor
class SearchListViewModel: ObservableObject {

    @Published private(set) var coins = [Coin]()
    @Published private(set) var searchResults: [Coin] = []
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    let coinGecko: CoinGeckoServiceProtocol

    init(coinGecko: CoinGeckoServiceProtocol, coins: [Coin] = []) {
        self.coinGecko = coinGecko
        self.coins = coins
    }

    func fetchCoins() async {
        if let coins = try? await coinGecko.fetchCoins(coinIds: [], currency: userCurrency.rawValue) {
            self.coins = coins
            self.searchResults = coins
        }
    }

    func searchResults(from searchText: String) {
        let lowercased = searchText.lowercased()
        searchResults = coins.filter { $0.name.lowercased().contains(lowercased) || searchText.isEmpty }
    }
}
