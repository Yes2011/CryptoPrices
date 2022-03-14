//
//  Coin.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import Foundation

struct Coin: Codable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let price: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let high24h: Double
    let low24h: Double

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case price = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case high24h = "high_24h"
        case low24h = "low_24h"
    }
}

extension Coin {
    static var testCoin1 = Coin(id: "bitcoin",
                                symbol: "bitcoin",
                                name: "Bitcoin",
                                image: "abc",
                                price: 2550.02,
                                priceChange24h: -247.01,
                                priceChangePercentage24h: -2.4,
                                high24h: 3000.0,
                                low24h: 1500.00)
    static var testCoin2 = Coin(id: "abc",
                                symbol: "abc",
                                name: "ABC",
                                image: "abc",
                                price: 120.0,
                                priceChange24h: 330,
                                priceChangePercentage24h: 2,
                                high24h: 3289.321,
                                low24h: 1465.241)
}
