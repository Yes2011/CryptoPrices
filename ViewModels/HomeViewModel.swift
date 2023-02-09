//
//  HomeViewModel.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 01/03/2022.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {

    @Published private(set) var global = Global()
    @Published private(set) var coins: [Coin] = []
    @Published private(set) var lastUpdate: Date?
    @AppStorage(AppStorageKey.coins) private var userCoins: String = CoinName.bitcoin
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    let coinGecko: CoinGeckoServiceProtocol

    init(coinGecko: CoinGeckoServiceProtocol, global: Global = Global()) {
        self.coinGecko = coinGecko
        self.global = global
        self.coins = storedCoins
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            Task {
                await self.reload()
            }
        }
    }

    func fetchGlobal() async {
        if let global = try? await coinGecko.fetchGlobal() {
            self.global = global
        }
    }

    func fetchCoins() async {
        guard !userCoins.isEmpty else { return }
        if let coins = try? await coinGecko.fetchCoins(coinIds: storedCoins.map { $0.id },
                                                       currency: userCurrency.rawValue) {
            self.coins = coins
            self.lastUpdate = Date()
        }
    }

    func reload() async {
        await fetchGlobal()
        await fetchCoins()
    }

    func updateUserCoins(value: String) {
        userCoins = value
    }

    func deleteUserCoin(idxSet: IndexSet) {
        coins.remove(atOffsets: idxSet)
        userCoins = coins.map {
            $0.id
        }.joined(separator: Strings.space)
    }

    var storedCoins: [Coin] {
        userCoins.trimmingCharacters(in: .whitespaces)
            .components(separatedBy: .whitespaces).map {
            Coin(id: $0,
                 symbol: "",
                 name: "",
                 image: "",
                 price: 0,
                 priceChange24h: 0.0,
                 priceChangePercentage24h: 0.0,
                 high24h: 0.0,
                 low24h: 0.0)
        }
    }
}
