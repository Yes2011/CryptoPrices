//
//  CoinPriceView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 10/03/2022.
//

import SwiftUI

struct CoinPriceView: View {

    let value: Double?
    let font: Font
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    var body: some View {
        Text("\(userCurrency.symbol)\(String(format: "%.2f", value ?? 0))")
            .font(font)
    }
}

struct CoinPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CoinPriceView(value: 123.1, font: .body.weight(.regular))
    }
}
