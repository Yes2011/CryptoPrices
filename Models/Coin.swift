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
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let high24h: Double?
    let low24h: Double?

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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        symbol = try values.decode(String.self, forKey: .symbol)
        name = try values.decode(String.self, forKey: .name)
        image = try values.decode(String.self, forKey: .image)
        price = try values.decode(Double.self, forKey: .price)
        priceChange24h = try values.decodeIfPresent(Double.self, forKey: .priceChange24h)
        priceChangePercentage24h = try values.decodeIfPresent(Double.self, forKey: .priceChangePercentage24h)
        high24h = try values.decodeIfPresent(Double.self, forKey: .high24h)
        low24h = try values.decodeIfPresent(Double.self, forKey: .low24h)
    }

    init(id: String,
         symbol: String,
         name: String,
         image: String,
         price: Double,
         priceChange24h: Double,
         priceChangePercentage24h: Double,
         high24h: Double,
         low24h: Double) {

        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.price = price
        self.priceChange24h = priceChange24h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.high24h = high24h
        self.low24h = low24h
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
