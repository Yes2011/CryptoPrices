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

struct CoinPrice: Identifiable {
    var id: UUID
    let timestamp: TimeInterval
    let price: Double
}
