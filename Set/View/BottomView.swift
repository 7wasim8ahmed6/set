//
//  BottomView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 22.07.24.
//

import SwiftUI

struct BottomBarView: View {
    @State private var showInfoSheet = false
    let InfoString:String
    var drawCards: () -> Void
    var provideHint: () -> Void
    
    var body: some View {
        HStack {
            // Info Button
                       Button(action: {
                           showInfoSheet.toggle()
                       }) {
                           Image(systemName: "info.circle")
                               .font(.title)
                               .foregroundColor(.gray)
                       }
                       .sheet(isPresented: $showInfoSheet) {
                                       InfoView(scoringInfo: InfoString, showInfoSheet: $showInfoSheet)
                                   }
                       
                       Spacer()
            
            // Hint Button
            Button(action: provideHint) {
                HStack {
                    Image(systemName: "lightbulb")
                    Text("Hint")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
                .shadow(radius: 5)
            }

            Button(action: drawCards) {
                Text("Draw Cards")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
    }
}


