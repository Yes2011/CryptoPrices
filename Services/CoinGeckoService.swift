//
//  CoinGecko.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import Foundation

struct CoinGeckoService {
    let coinGeckoBase = "https://api.coingecko.com/api/v3"

    func fetchCoins(coinIds: [String] = [], currency: String = "usd") async throws -> [Coin]? {

        let apiURLString = coinGeckoBase + "/coins/markets"

        let parameters = [
            "vs_currency": currency,
            "order": "market_cap_desc",
            "per_page": "250",
            "page": "1",
            "sparkline": "false"
        ]

        var coinsURLComponents = URLComponents(string: apiURLString)!
        coinsURLComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })

        if !coinIds.isEmpty {
            let joinedCoinIds = coinIds.joined(separator: ", ")
            let escapedJoinedCoinIds = joinedCoinIds.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            if let percentQuery = coinsURLComponents.percentEncodedQuery, let encodedCoinIds = escapedJoinedCoinIds {
                coinsURLComponents.percentEncodedQuery = percentQuery + "&ids=" + encodedCoinIds
            }
        }

        guard let url = coinsURLComponents.url else { return nil }
        var coins: [Coin]?
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            coins = try JSONDecoder().decode([Coin].self, from: data)
        } catch {
            debugPrint(error)
        }
        return coins
    }

    func fetchMarketData(coinId: String, currency: String = "usd", days: Int = 1) async throws -> CoinMarketData? {

        let apiURLString = coinGeckoBase + "/coins/\(coinId)/market_chart?vs_currency=\(currency)&days=\(days)"
        guard let url = URL(string: apiURLString) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        var coinMarketData: CoinMarketData?
        do {
            coinMarketData = try JSONDecoder().decode(CoinMarketData.self, from: data)
        } catch {
            debugPrint("ERROR:", error)
        }
        return coinMarketData
    }

    func fetchGlobal() async throws -> Global? {

        guard let url = URL(string: coinGeckoBase + "/global") else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        var global: Global?
        do {
            global = try JSONDecoder().decode(Global.self, from: data)
        } catch {
            debugPrint("ERROR:", error)
        }
        return global
    }
}
