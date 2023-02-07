//
//  CoinView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 28/02/2022.
//

import SwiftUI

struct CoinView: View {

    var coin: Coin
    let showExtended: Bool
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: Padding.large) {
                coinLogo
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(coin.name)
                            .font(.title.weight(.semibold))
                        Spacer()
                        if showExtended {
                            coin.priceChangePercentage24h != nil ?
                            Text(String(format: "%.1f", coin.priceChangePercentage24h!) + Strings.percent) : Text("-")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(changePercentage(value: coin.priceChangePercentage24h,
                                                              colorScheme: colorScheme))
                        }
                    }
                    HStack {
                        Text(coin.symbol.uppercased())
                            .font(.footnote)
                        .foregroundColor(Color.secondary)
                        Spacer()
                        if showExtended {
                            Text("\(userCurrency.symbol)\(String(format: "%.2f", coin.price))")
                            .font(.caption)
                        }
                    }
                }
                Spacer()
            }
            .frame(height: 64)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black.opacity(0.05))
            )
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }

    var coinLogo: some View {
        AsyncImage(url: coinImageUrl, transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                Image(systemName: ImageName.cloud)
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            @unknown default:
                Image(systemName: ImageName.cloud)
            }
        }
        .imageFrameStyle()
        .padding(Padding.standard)
        .background(.ultraThinMaterial)
        .mask(Circle())
        .padding(.leading, Padding.standard)
    }
}

extension CoinView {
    var coinImageUrl: URL? {
        let imageStringSmall = coin.image.replacingOccurrences(of: "large", with: "small")
        return URL(string: imageStringSmall)
    }
}

struct CoinView_Previews: PreviewProvider {
    static let coin = Coin.testCoin1
    static var previews: some View {
        CoinView(coin: coin, showExtended: true)
    }
}
