//
//  CreditsView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 09/03/2022.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        HStack {
            Text("App Creator: Crispin Lingford")
                .font(.callout.weight(.regular))
            Link(destination: URL(string: "https://www.linkedin.com/in/crispinlingforddeveloper")!) {
                Image("LI-In-Bug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25.4, height: 21.6)
                    .padding(.leading, Padding.small)
                    .padding(.trailing, 1)
                    .padding(.vertical, Padding.small)
                    .background(Color.white)
                    .cornerRadius(4)
            }
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
