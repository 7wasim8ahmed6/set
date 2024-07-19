//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    let theGameView: SetGame

    var body: some View {
        VStack {
            if theGameView.theSetGame.mDrawCards.count <= 25 {
                AspectVGrid(items: theGameView.theSetGame.mDrawCards, aspectRatio: 2/3) { card in
                    CardView(content: AnyView(SquiggleView(number: 3, fillingType: .solid, color: .red)))
                        .aspectRatio(2/3, contentMode: .fit)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                        ForEach(0..<81) { i in
                            CardView(content: AnyView(SquiggleView(number: 3, fillingType: .solid, color: .red)))
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
            }
            
            HStack {
                Button(action: {
                    // Add your action here
                }) {
                    Text("Draw Cards")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 100)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                Spacer()
                Button(action: {
                    // Add your action here
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
        .padding()
    }
}





























struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = SetGame()
        
        Group {
            SetGameView(theGameView: game)
                .preferredColorScheme(.light)
                .previewDisplayName("Light Theme")
            
            SetGameView(theGameView: game)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Theme")
        }
    }
}
