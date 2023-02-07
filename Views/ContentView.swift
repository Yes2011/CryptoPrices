//
//  ContentView.swift
//  Shared
//
//  Created by YES 2011 Limited on 22/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView(homeVm: HomeViewModel(coinGecko: CoinGeckoService()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
