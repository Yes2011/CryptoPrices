//
//  SettingsViewModel.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 09/03/2022.
//

import Foundation
import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {

    @Published private(set) var currency: Currency = .usd
    private(set) var maxPrice: Double = 0
    private(set) var minPrice: Double = 0
    private(set) var priceRange: Double = 0
    @AppStorage(AppStorageKey.currency) private var userCurrency: Currency = .usd

    init() {
        updateCurrency()
    }

    func updateUserCurrency(_ currency: Currency) {
        userCurrency = currency
        updateCurrency()
    }

    private func updateCurrency() {
        currency = userCurrency
    }
}
