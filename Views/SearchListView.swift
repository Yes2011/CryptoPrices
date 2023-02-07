//
//  SearchListView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 28/02/2022.
//

import SwiftUI

struct SearchListView: View {

    @StateObject var viewModel = SearchListViewModel()
    @Binding var showSearch: Bool
    @State var searchText = ""
    @State var showCoinDetail = false
    @State var tappedCoin: Coin?

    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                searchList
                .scrollContentBackground(.hidden)
            } else {
                searchList
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { searchText in
            viewModel.searchResults(from: searchText)
        }
    }

    var searchList: some View {
        List {
            ForEach(0..<viewModel.searchResults.count, id: \.self) { coinIdx in
                Button {
                    showCoinDetail = true
                    tappedCoin = viewModel.searchResults[coinIdx]
                } label: {
                    CoinView(coin: viewModel.searchResults[coinIdx], showExtended: false)
                }
                .buttonStyle(.plain)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .padding(.horizontal, -Padding.large)
        .environment(\.defaultMinListRowHeight, 60)
        .task {
            await viewModel.fetchCoins()
        }
        .navigationTitle("Search")
        .background(BackgroundBlob(imageName: BlobName.bg2,
                                   offsetX: -200,
                                   offsetY: 0,
                                   opacity: 1))
        .sheet(isPresented: $showCoinDetail) {
            CoinDetailView(showCoinDetail: $showCoinDetail, coin: $tappedCoin)
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(showSearch: .constant(false))
    }
}
