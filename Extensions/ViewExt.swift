//
//  ViewExt.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 08/03/2022.
//

import Foundation
import SwiftUI

extension View {

    func changePercentage(value: Double, colorScheme: ColorScheme) -> Color {
        value > 0 ? Color.green : value < 0 ? Color.red : colorScheme == .dark ? Color.white : Color.black
    }

    func centerViewStyle() -> some View {
        modifier(CenterViewStyle())
    }

    func foregroundColorStyle(lightOpacity: Double = 1.0) -> some View {
        modifier(ForegroundColorStyle(lightOpacity: lightOpacity))
    }

    func imageFrameStyle(_ size: ImageFrameStyleType = .standard) -> some View {
        modifier(ImageFrameStyle(size: size))
    }
}
