//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var theGameView: SetGame
    
    static let cardPadding:CGFloat = 2
    var body: some View {
        VStack {
            if theGameView.theSetGame.mGameFinished {
                Text("😎 Congratulations! You've finished the game with a score of \( theGameView.theSetGame.mScore.points)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding()
                
                HStack {
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
        .padding(.horizontal)
    }
}

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

//            Spacer()
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
