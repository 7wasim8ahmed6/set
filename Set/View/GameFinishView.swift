//
//  GameFinishView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 22.07.24.
//

import SwiftUI


struct GameFinishView : View {
    let points:Int
    let newGame:() -> Void
    var body: some View {
        Text("😎 Congratulations! You've finished the game with a score of \( points)!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.green)
            .padding()
        
        HStack {
            Button(action: {
                newGame()
            }) {
                Text("Start Fresh")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 100)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding(.horizontal)
    }
}
