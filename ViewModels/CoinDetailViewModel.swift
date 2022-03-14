//
//  CoinDetailViewModel.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 01/03/2022.
//

import Foundation
import SwiftUI

@MainActor
class CoinDetailViewModel: ObservableObject {

    @Published private(set) var coinPrices: [CoinPrice] = []
    private(set) var maxPrice: Double = 0
    private(set) var minPrice: Double = 0
    private(set) var priceRange: Double = 0
    @AppStorage(AppStorageKey.coins) private var userCoins: String = CoinName.bitcoin
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    let coinGecko = CoinGeckoService()

    func fetchMarketData(coin: Coin?, days: Int = 1) async {
        guard coin != nil else { return }
        if let marketData = try? await coinGecko.fetchMarketData(coinId: coin!.id,
                                                                 currency: userCurrency.rawValue,
                                                                 days: days) {
            self.coinPrices = marketData.prices.map { priceData in
                CoinPrice(id: UUID(), timestamp: priceData[0], price: priceData[1])
            }
            calcPriceMinMaxRange()
        }
    }

    func calcPriceMinMaxRange() {
        let prices = coinPrices.map { $0.price }
        maxPrice = prices.max() ?? 0.0
        minPrice = prices.min() ?? 0.0
        priceRange = maxPrice - minPrice
    }

    func addToFavorites(coin: Coin?) {
        guard let coin = coin else { return }
        userCoins += Strings.space + "\(coin.id)"
    }

    func userCoins(contains coin: Coin?) -> Bool {
        guard let coin = coin else { return false }
        return !userCoins.components(separatedBy: .whitespaces).map {
            $0
        }.filter {
            $0 == coin.id
        }.isEmpty
    }
}
