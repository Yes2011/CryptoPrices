//
//  Currency.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 09/03/2022.
//

import Foundation

enum Currency: String, CaseIterable {

    case ars, aud, bmd, brl, chf, clp, cny, czk, dkk, eur, gbp,
         hkd, huf, jpy, ils, inr, krw, lkr, mxn, myr, ngn, nok,
         nzd, php, pkr, pln, rub, sar, sek, sgd, thb, tlr = "try",
         twd, uah, vnd, usd, zar
}

extension Currency: Identifiable {
    var id: RawValue { rawValue }
}

extension Currency {

    var symbol: String {
        switch self {
        case .ars: return Strings.dollar
        case .aud: return Strings.dollar
        case .bmd: return Strings.dollar
        case .brl: return "R$"
        case .chf: return "CHF"
        case .clp: return "£"
        case .cny: return "¥"
        case .czk: return "Kč"
        case .dkk: return "kr"
        case .eur: return "€"
        case .gbp: return "£"
        case .hkd: return Strings.dollar
        case .huf: return "Ft"
        case .ils: return "₪"
        case .inr: return "₹"
        case .jpy: return "¥"
        case .krw: return "₩"
        case .lkr: return "Rs"
        case .mxn: return Strings.dollar
        case .myr: return "RM"
        case .ngn: return "₦"
        case .nok: return "kr"
        case .nzd: return "$"
        case .php: return "₱"
        case .pkr: return "Rs"
        case .pln: return "zł"
        case .rub: return "₽"
        case .sar: return "﷼"
        case .sek: return "kr"
        case .sgd: return "$"
        case .thb: return "฿"
        case .tlr: return "₺"
        case .twd: return "NT$"
        case .uah: return "₴"
        case .vnd: return "₫"
        case .usd: return Strings.dollar
        case .zar: return "R"
        }
    }
}
