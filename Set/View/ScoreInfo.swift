//
//  ScoreInfo.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 21.07.24.
//

import SwiftUI

struct InfoView: View {
    let scoringInfo: String
    @Binding var showInfoSheet: Bool
    

    var body: some View {
        VStack(spacing: 20) {
            Text("Points Scoring Info")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(scoringInfo)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()

            Button(action: {
                showInfoSheet = false
            }) {
                Text("Got it!")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding()
    }
}
