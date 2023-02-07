//
//  CoinMarketData.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 01/03/2022.
//

import Foundation

struct CoinMarketData: Decodable {
    let prices: [[Double]]
}

extension CoinMarketData {
    static var testCoinMarketData = CoinMarketData(prices: [[1.01, 2.02, 3.03], [4.2, 5.3, 5.4]])
}

struct CoinPrice: Identifiable {
    var id: UUID
    let timestamp: TimeInterval
    let price: Double
}

extension CoinPrice {
    static var testCoinPrice = CoinPrice(id: UUID(uuidString: "1")!, timestamp: 123.45, price: 1.20)
}
