//
//  BackgroundBlob.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 09/03/2022.
//

import SwiftUI

struct BlobName {
    static let bg1 = "CryptoCheckerBg"
    static let bg2 = "CryptoCheckerBg2"
}

struct BackgroundBlob: View {
    let imageName: String
    var offsetX: CGFloat
    var offsetY: CGFloat
    var opacity: Double

    var body: some View {
        Image(imageName)
                .resizable()
                .scaledToFill()
                .opacity(opacity)
                .ignoresSafeArea()
                .offset(x: offsetX, y: offsetY)
    }
}

struct BackgroundBlob_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBlob(imageName: BlobName.bg2, offsetX: -100, offsetY: 0, opacity: 0.75)
    }
}
