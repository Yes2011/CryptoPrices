//
//  HomeView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import Foundation
import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel
    @State var showSearch: Bool = false
    @State var showSettings: Bool = false
    @State var showCoinDetail: Bool = false
    @State var tappedCoin: Coin?
    @Environment(\.colorScheme) var colorScheme
    @State var showNetworkAlert: Bool = false
    @AppStorage(AppStorageKey.coins) private var userCoins: String = CoinName.bitcoin
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    init(homeVm: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: homeVm)
    }

    var body: some View {
        VStack(spacing: 8) {
            if #available(iOS 16.0, *) {
                savedCoinList
                .scrollContentBackground(.hidden)
            } else {
                savedCoinList
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            }
            HStack {
                Spacer()
                Button {
                    showSettings.toggle()
                } label: {
                    Text("¤")
                        .font(.system(size: 28, weight: .light))
                        .foregroundColorStyle(lightOpacity: 0.8)
                        .imageFrameStyle(.large)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(showSettings: $showSettings)
                }
                .background(.regularMaterial)
                .cornerRadius(44)
            }
            .padding(.trailing, -Padding.standard)
            .padding(.bottom, Padding.medium)
            .overlay(footer)
        }
        .padding([.top, .horizontal], Padding.large)
        .background(BackgroundBlob(imageName: BlobName.bg1,
                                   offsetX: -120,
                                   offsetY: -2,
                                   opacity: 1).ignoresSafeArea())
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .refreshable {
            await viewModel.reload()
        }
        .task {
            await viewModel.reload()
            debugPrint("onAppear reload")
        }
        .onChange(of: userCurrency, perform: { _ in
            Task {
                await viewModel.reload()
            }
        })
        .overlay(searchButton)
    }

    var savedCoinList: some View {
        List {
            Section(header: change(value: viewModel.global.data.change)) {
                ForEach(viewModel.coins, id: \.self) { coin in
                    Button {
                        showCoinDetail = true
                        tappedCoin = coin
                    } label: {
                        CoinView(coin: coin, showExtended: true)
                    }
                    .buttonStyle(.plain)
                }
                .onDelete { idxSet in
                    viewModel.deleteUserCoin(idxSet: idxSet)
                }
            }
            .textCase(nil)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.grouped)
        .padding([.top, .horizontal], -Padding.large)
        .environment(\.defaultMinListRowHeight, 60)
        .sheet(isPresented: $showCoinDetail) {
            CoinDetailView(coinDetailVm: CoinDetailViewModel(coinGecko: CoinGeckoService()),
                           showCoinDetail: $showCoinDetail,
                           coin: $tappedCoin)
        }
        .onChange(of: userCoins) { newState in
            viewModel.updateUserCoins(value: newState)
            Task {
                await viewModel.reload()
            }
        }

    }
}

extension HomeView {

    var searchButton: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Button {
                        showSearch.toggle()
                    } label: {
                        Image(systemName: ImageName.search)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColorStyle()
                            .imageFrameStyle()
                    }
                    .sheet(isPresented: $showSearch) {
                        SearchListView(searchListVm: SearchListViewModel(coinGecko: CoinGeckoService()),
                                       showSearch: $showSearch)
                    }
                    .background(.thickMaterial)
                    .cornerRadius(36)
                }
            }
            Spacer()
        }
        .padding([.top, .trailing], Padding.standard)
    }

    func change(value: Double) -> some View {
        VStack {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text("24 hr")
                    .font(.caption.weight(.light))
                HStack(spacing: 0) {
                    Text(value > 0 ? Strings.plus : "")
                        .font(.largeTitle)
                        .foregroundColor(changePercentage(value: value, colorScheme: colorScheme))
                    Text(String(round(value * 10) / 10.0) + " \(Strings.percent)")
                        .font(.largeTitle.bold())
                    .foregroundColor(changePercentage(value: value, colorScheme: colorScheme))
                 }
                Text("Global market cap. (\(Strings.dollar))")
                    .font(.caption.weight(.regular))
                    .foregroundColorStyle()
            }
            .centerViewStyle()
            Spacer()
        }
        .padding(.bottom, 8)
        }
    }

    var footer: some View {
        VStack {
            Text("Made by Crispin Lingford")
                    .font(.caption)
            Text("Powered by CoinGecko API")
                    .font(.system(size: 10, weight: .light))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(homeVm: HomeViewModel(coinGecko: CoinGeckoPreviewService()))
                .previewDevice("iPhone 14 Pro Max")
            HomeView(homeVm: HomeViewModel(coinGecko: CoinGeckoPreviewService()))
                .previewDevice("iPhone 14")
            HomeView(homeVm: HomeViewModel(coinGecko: CoinGeckoPreviewService()))
                .preferredColorScheme(.dark)
        }
    }
}
