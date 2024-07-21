//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var theGameView: SetGame
    
    // Timer related states (Example)
    @State private var timeRemaining = 60  // Example timer in seconds
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            // Top Bar with Timer, Info and Hint Button
            TopBarView(timeRemaining: timeRemaining, newGame: theGameView.newGame, showScoringInfo: showScoringInfo)
            
            if theGameView.theSetGame.mGameFinished {
                Text("Congratulations! You've finished the game😎!")
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
                            ForEach(theGameView.theSetGame.mDrawCards) { card in
                                theGameView.interpretCard(aCard: card)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .onTapGesture {
                                        theGameView.choose(aCard: card)
                                    }
                            }
                        }
                    }
                }
                
                // Bottom Bar with Draw Cards and Start Fresh Button
                BottomBarView(drawCards: {
                    theGameView.drawCards()
                })
            }
        }
        .padding(.horizontal)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // Timer functions
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func showScoringInfo() {
        // Implement the action to show scoring information
        // This could be a modal or an alert
    }
}

struct TopBarView: View {
    var timeRemaining: Int
    var newGame:()->Void
    var showScoringInfo: () -> Void
    
    var body: some View {
        HStack {
            VStack{
                Text("Points: 200")
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
    var drawCards: () -> Void
    
    var body: some View {
        HStack {
            // Info Button
                       Button(action: {}) {
                           Image(systemName: "info.circle")
                               .font(.title)
                               .foregroundColor(.gray)
                       }
                       
                       Spacer()
            
            // Hint Button
            Button(action: {}) {
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
