//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var theGameView: SetGame
    @State private var showWelcomeScreen = true
    static let cardPadding:CGFloat = 2
    var body: some View {
        VStack {
            if showWelcomeScreen {
                WelcomeView(showWelcomeScreen: $showWelcomeScreen, welcomeMessage: theGameView.getWelcomeMessage())
            }
            else{
                if theGameView.theSetGame.mGameFinished {
                    GameFinishView(points: theGameView.theSetGame.mScore.points, newGame: theGameView.newGame)
                } else {
                    // Top Bar with Timer, Info and Hint Button
                    TopBarView(timeRemaining: theGameView.timeRemaining, newGame: theGameView.newGame, Pts: theGameView.theSetGame.mScore.points)
                    
                    if theGameView.theSetGame.mDrawCards.count <= 16 {
                        AspectVGrid(items: theGameView.theSetGame.mDrawCards, aspectRatio: 2/3) { card in
                            theGameView.interpretCard(aCard: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .padding(SetGameView.cardPadding)
                                .background(theGameView.hintCard == card ? Color.yellow : Color.clear) // Highlight hint card
                                .onTapGesture {
                                    theGameView.choose(aCard: card)
                                }
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 73), spacing: 0)], spacing: 0) {
                                ForEach(theGameView.theSetGame.mDrawCards) { card in
                                    theGameView.interpretCard(aCard: card)
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .padding(SetGameView.cardPadding)
                                        .background(theGameView.hintCard == card ? Color.yellow : Color.clear) // Highlight hint card
                                        .onTapGesture {
                                            theGameView.choose(aCard: card)
                                        }
                                }
                            }
                        }
                    }
                    
                    // Bottom Bar with Draw Cards and Start Fresh Button
                    BottomBarView(InfoString: theGameView.getScoringInfo(), drawCards: {
                        theGameView.drawCards()
                    }, provideHint: theGameView.provideHint)
                }
            }
        }
        .padding(.horizontal)
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
