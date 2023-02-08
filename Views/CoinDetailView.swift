//
//  CoinDetailView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 28/02/2022.
//

import SwiftUI

enum DataTimeInterval: Int, CaseIterable {
    case day = 1
    case days30 = 30
    case days90 = 90
    case days180 = 180
    case year1 = 365

    var description: String {
        switch self {
        case .day: return "24h"
        case .days30: return "30d"
        case .days90: return "90d"
        case .days180: return "180d"
        case .year1: return "1y"
        }
    }
}

extension DataTimeInterval: Identifiable {
    var id: RawValue { rawValue }
}

struct CoinDetailView: View {

    @StateObject var viewModel: CoinDetailViewModel
    @Binding var showCoinDetail: Bool
    @Binding var coin: Coin?
    @Environment(\.colorScheme) var colorScheme
    @State var pickerInterval: Int = 1
    @State var isFavoriteAdded = false
    @EnvironmentObject var monitor: NetworkMonitor

    init(coinDetailVm: CoinDetailViewModel, showCoinDetail: Binding<Bool>, coin: Binding<Coin?>) {
        self._viewModel = StateObject(wrappedValue: coinDetailVm)
        self._showCoinDetail = showCoinDetail
        self._coin = coin
    }

    var body: some View {
        VStack {
            HStack {
                Text(coin?.name ?? "")
                    .font(.title.weight(.semibold))
                    .padding(Padding.large)
                Spacer()
                Button {
                    showCoinDetail.toggle()
                } label: {
                    Image(systemName: ImageName.close)
                        .foregroundColorStyle(lightOpacity: 0.8)
                }
                .padding(Padding.standard)
                .background(Circle().fill(.ultraThinMaterial))
            }
            .padding([.top, .trailing], Padding.medium)
            HStack {
                Text("current price:")
                    .font(.body.weight(.regular))
                Spacer()
                CoinPriceView(value: coin?.price)
            }
            .padding(.horizontal, Padding.large)
            ChartView(viewModel: viewModel)
                .frame(height: 180)
                .background(Color.clear)
                .padding(Padding.standard)
                .background(Color.white.opacity(0.9))
                .cornerRadius(4)
                .padding(Padding.large)

            Picker("", selection: $pickerInterval) {
                ForEach(DataTimeInterval.allCases) { interval in
                    Text(interval.description).tag(interval.rawValue)
                        .font(.caption.weight(.light))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, Padding.large)
            .onChange(of: pickerInterval) { newValue in
                Task {
                    await viewModel.fetchMarketData(coin: coin, days: newValue)
                }
            }
            highLow
                .padding([.top, .horizontal], Padding.large)
            Spacer()
            if !viewModel.userCoins(contains: coin) {
                HStack {
                    Spacer()
                    Button {
                        viewModel.addToFavorites(coin: coin)
                        isFavoriteAdded = true
                    } label: {
                        Image(systemName: ImageName.plus)
                            .font(.title)
                            .imageFrameStyle(.large)
                            .foregroundColorStyle(lightOpacity: 0.9)
                            .background(Circle().fill(.regularMaterial))
                    }
                    .disabled(false)
                    .padding(.bottom, Padding.large)
                    .padding(.trailing, Padding.medium)
                }
            }
        }
        .task {
            await viewModel.fetchMarketData(coin: coin)
        }
        .onAppear {
            UISegmentedControl
                .appearance()
                .setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 11)], for: .normal)
            UISegmentedControl
                .appearance()
                .setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        }
        .background(BackgroundBlob(imageName: BlobName.bg1, offsetX: -200, offsetY: -3, opacity: 0.75))
        .alert(isPresented: $isFavoriteAdded) {
            Alert(title: Text("CryptoChecker"),
                  message: Text("\(coin?.name ?? "") has been added to your favorites"),
                  dismissButton: .cancel(Text("Ok")))
         }
        .overlay(NetworkMonitorView(status: monitor.status))
    }
}

extension CoinDetailView {

    var highLow: some View {
        VStack(spacing: 8) {
            HStack {
                Text("24h high:")
                    .font(.body.weight(.regular))
                Spacer()
                CoinPriceView(value: coin?.high24h)
            }
            HStack {
                Text("24h low:")
                    .font(.body.weight(.regular))
                Spacer()
                CoinPriceView(value: coin?.low24h)
                    .font(.body.weight(.regular))
            }
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinDetailView(coinDetailVm: CoinDetailViewModel(coinGecko: CoinGeckoPreviewService()),
                           showCoinDetail: .constant(true),
                           coin: .constant(Coin.testCoin1))
            .environmentObject(NetworkMonitor())
            CoinDetailView(coinDetailVm: CoinDetailViewModel(coinGecko: CoinGeckoPreviewService()),
                           showCoinDetail: .constant(true),
                           coin: .constant(Coin.testCoin1))
                .previewDevice("iPhone 13 Pro Max")
                .environmentObject(NetworkMonitor())
        }
    }
}
