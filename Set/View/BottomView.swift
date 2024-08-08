//
//  BottomView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 22.07.24.
//

import SwiftUI

struct BottomBarView: View {
    @State private var showInfoSheet = false
    let InfoString: String
    var drawCards: () -> Void
    var provideHint: () -> Void
    
    var body: some View {
        HStack {
            // Info Button
            Button(action: {
                showInfoSheet.toggle()
            }) {
                Image(systemName: Constants.infoIconName)
                    .font(Constants.iconFont)
                    .foregroundColor(Constants.iconColor)
            }
            .sheet(isPresented: $showInfoSheet) {
                InfoView(scoringInfo: InfoString, showInfoSheet: $showInfoSheet)
            }
            
            Spacer()
            
            // Hint Button
            Button(action: provideHint) {
                HStack {
                    Image(systemName: Constants.hintIconName)
                    Text(Constants.hintText)
                        .fontWeight(Constants.buttonFontWeight)
                }
                .foregroundColor(Constants.buttonTextColor)
                .padding(Constants.buttonPadding)
                .background(Constants.hintButtonColor)
                .cornerRadius(Constants.cornerRadius)
                .shadow(radius: Constants.shadowRadius)
            }
            
            // Draw Cards Button
            Button(action: drawCards) {
                Text(Constants.drawCardsText)
                    .fontWeight(Constants.buttonFontWeight)
                    .foregroundColor(Constants.buttonTextColor)
                    .padding(Constants.buttonPadding)
                    .background(Constants.drawCardsButtonColor)
                    .cornerRadius(Constants.cornerRadius)
                    .shadow(radius: Constants.shadowRadius)
            }
        }
        .padding(.horizontal)
    }
    
    private struct Constants {
        // Icon
        static let infoIconName = "info.circle"
        static let hintIconName = "lightbulb"
        
        // Text
        static let hintText = "Hint"
        static let drawCardsText = "Draw Cards"
        
        // Fonts and Weights
        static let iconFont: Font = .title
        static let buttonFontWeight: Font.Weight = .bold
        
        // Colors
        static let iconColor: Color = .gray
        static let hintButtonColor: Color = .orange
        static let drawCardsButtonColor: Color = .blue
        static let buttonTextColor: Color = .white
        
        // Layout
        static let buttonPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 5
    }
}

