//
//  ForegroundColorStyle.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 10/03/2022.
//

import Foundation
import SwiftUI

struct ForegroundColorStyle: ViewModifier {

    @Environment(\.colorScheme) var colorScheme
    let lightOpacity: Double

    func body(content: Content) -> some View {
            return content
            .foregroundColor(colorScheme == .dark ? .white : .black.opacity(lightOpacity))
    }
}
