//
//  NetworkMonitor.swift
//  CryptoChecker (iOS)
//
//  Created by Crispin Lingford on 07/02/2023.
//
// SO: https://stackoverflow.com/a/65819059
// Author: https://stackoverflow.com/users/5508175/andrew

import Network
import SwiftUI

// An enum to handle the network status
enum NetworkStatus: String {
    case connected
    case disconnected
}

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var status: NetworkStatus = .connected

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if path.status == .satisfied {
                    debugPrint("We're connected!")
                    self.status = .connected
                } else {
                    debugPrint("No connection.")
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
