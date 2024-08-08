//
//  TopView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 22.07.24.
//

import SwiftUI

struct TopBarView: View {
    var timeRemaining: Int
    var newGame:()->Void
    let Pts:Int
    
    private struct Constants {
        // Fonts and Weights
        static let pointsFont: Font = .title
        static let timeFont: Font = .title2
        static let fontWeight: Font.Weight = .bold
        
        // Colors
        static let textColor: Color = .brown
        static let buttonTextColor: Color = .white
        static let buttonBackgroundColor: Color = .red
        
        // Layout
        static let buttonCornerRadius: CGFloat = 10
        static let buttonShadowRadius: CGFloat = 5
        
        // Strings
        static let newGameText: String = "New Game"
        static let timeFormat: String = "%02d:%02d"
    }
    
    var body: some View {
        HStack {
            VStack{
                Text("Points: \(Pts)")
                    .font(Constants.pointsFont)
                    .fontWeight(Constants.fontWeight)
                
                Text("Time: \(timeFormatted(timeRemaining))")
                    .font(Constants.timeFont)
                                .fontWeight(Constants.fontWeight)
            }.foregroundColor(Constants.textColor)
            
            Spacer()
            
            Button(action: newGame) {
                Text(Constants.newGameText)
                                .fontWeight(Constants.fontWeight)
                                .foregroundColor(.white)
                                .padding()
                                .background(Constants.buttonBackgroundColor)
                                .cornerRadius(Constants.buttonCornerRadius)
                                .shadow(radius: Constants.buttonShadowRadius)
                        }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: Constants.timeFormat, minutes, seconds)
    }
}
