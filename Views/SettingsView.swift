//
//  SettingsView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 09/03/2022.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSettings: Bool

    let columns = [GridItem(.adaptive(minimum: 60))]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                closeButton
            }
            .padding([.top, .trailing], Padding.medium)
            HStack(alignment: .center) {
                Spacer()
                header
                Spacer()
             }
            currencyOptions
                .padding(.top, Padding.large)
                .padding(.horizontal, Padding.medium)
            Spacer()
        }
        .background(BackgroundBlob(imageName: BlobName.bg1,
                                   offsetX: -150,
                                   offsetY: 0,
                                   opacity: 0.75))
    }

    var header: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("App Currency")
                .font(.caption.weight(.light))
            HStack(spacing: 0) {
                Text(viewModel.currency.rawValue.uppercased())
                    .font(.largeTitle)
             }
            Text("Symbol: \(viewModel.currency.symbol)")
                .font(.caption.weight(.regular))
                .foregroundColorStyle()
        }
        .frame(width: 140)
        .centerViewStyle()
    }

    var closeButton: some View {
        Button {
            showSettings.toggle()
        } label: {
            Image(systemName: ImageName.close)
                .foregroundColorStyle(lightOpacity: 0.8)
        }
        .padding(Padding.standard)
        .background(Circle().fill(.ultraThinMaterial))
    }

    var currencyOptions: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    currencyOption(currency: currency)
                }
            }
            CreditsView()
        }
    }

    func currencyOption(currency: Currency) -> some View {
        Button {
            viewModel.updateUserCurrency(currency)
        }
        label: {
            VStack {
                Text(currency.symbol)
                    .foregroundColorStyle(lightOpacity: 0.9)
                Text(currency.rawValue.uppercased())
                    .font(.caption)
                    .foregroundColorStyle(lightOpacity: 0.9)

            }
            .frame(width: 60)
            .padding(.vertical, Padding.small)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.black.opacity(0.025))
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true))
    }
}
