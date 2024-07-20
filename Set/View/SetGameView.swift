//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var theGameView: SetGame
    
    var body: some View {
        VStack {
            if theGameView.theSetGame.mDrawCards.count <= 16 {
                AspectVGrid(items: theGameView.theSetGame.mDrawCards, aspectRatio: 2/3) { card in
                    theGameView.interpretCard(aCard: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(1)
                        .onTapGesture {
                            theGameView.choose(aCard: card)
                        }
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                        ForEach(theGameView.theSetGame.mDrawCards){card in
                            theGameView.interpretCard(aCard: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    theGameView.choose(aCard: card)
                                }
                        }
                    }
                }
            }
            
            HStack {
                Button(action: {
                    theGameView.drawCards()
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
                    theGameView.newGame()
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
