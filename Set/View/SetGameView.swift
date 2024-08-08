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
    
    private struct GameViewConsts{
        static let AspectRatio:CGFloat = 2/3
        static let HintColor = Color.yellow
        static let CardPadding:CGFloat = 2
        static let GridCardMinSize:CGFloat = 73
        static let MaxAspectGridCards = 16
    }
    
    func GameCardView(_ card: Card) -> some View {
        theGameView.interpretCard(aCard: card)
            .aspectRatio(GameViewConsts.AspectRatio, contentMode: .fit)
            .padding(GameViewConsts.CardPadding)
            .background(theGameView.hintCard == card ? GameViewConsts.HintColor : Color.clear) // Highlight hint card
            .onTapGesture {
                theGameView.choose(aCard: card)
            }
    }
    
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
                    
                    if theGameView.theSetGame.mDrawCards.count <= GameViewConsts.MaxAspectGridCards {
                        AspectVGrid(items: theGameView.theSetGame.mDrawCards, aspectRatio: GameViewConsts.AspectRatio) { card in
                            GameCardView(card)
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: GameViewConsts.GridCardMinSize), spacing: 0)], spacing: 0) {
                                ForEach(theGameView.theSetGame.mDrawCards) { card in
                                    GameCardView(card)
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
