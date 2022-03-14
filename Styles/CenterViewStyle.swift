//
//  CenterViewStyle.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 10/03/2022.
//

import Foundation
import SwiftUI

struct CenterViewStyle: ViewModifier {

    func body(content: Content) -> some View {
            return content
                .frame(width: 140)
                .padding(.top, Padding.standard)
                .padding(.bottom, Padding.medium)
                .padding(.horizontal, Padding.large)
                .background(.regularMaterial)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.black.opacity(0.025))
                )
    }
}
