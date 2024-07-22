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
    
    var body: some View {
        HStack {
            VStack{
                Text("Points: \(Pts)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Time: \(timeFormatted(timeRemaining))")
                                .font(.title2)
                                .fontWeight(.bold)
            }.foregroundColor(.brown)
            
            Spacer()
            
            Button(action: newGame) {
                            Text("New Game")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
