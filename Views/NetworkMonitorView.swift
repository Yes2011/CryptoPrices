//
//  NetworkMonitorView.swift
//  CryptoChecker (iOS)
//
//  Created by Crispin Lingford on 07/02/2023.
//

import SwiftUI

struct NetworkMonitorView: View {

    var status: NetworkStatus

    var body: some View {
        switch status {
        case .connected:  EmptyView()
        case .disconnected:  hasNoConnectionView
        }
    }

    var hasConnectionView: some View {
        Image(systemName: "wifi")
            .font(.system(size: 48))
    }

    var hasNoConnectionView: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Text("No internet")
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 36))
                Spacer()
                Spacer()
            }
            .frame(width: 200, height: 200)
            .background(.white)
            .cornerRadius(16)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct NetworkMonitorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkMonitorView(status: NetworkStatus.disconnected)
    }
}
