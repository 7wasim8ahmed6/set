//
//  setGame.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import Combine
import SwiftUI

class SetGame: ObservableObject {
    @Published private(set) var theSetGame: Game
    @Published var timeRemaining: Int = 60
    @Published var hintCard: Card?
    private var timer: AnyCancellable?
    
    init() {
        self.theSetGame = Game()
        theSetGame.drawCards()
        startTimer()
    }
    
    func interpretCard(aCard: Card) -> CardView {
        let chosen = theSetGame.mChosenCards.contains(where: { $0.id == aCard.id })
        let matchedCard = theSetGame.mMatched.contains(where: { $0.id == aCard.id })
        return CardInterpreter.interpretCard(aCard, chosen: chosen, matched: matchedCard)
    }
    
    func getWelcomeMessage() -> String
    {
        return theSetGame.getWelcomeMessage()
    }
    
    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.updateTimeRemaining()
        }
    }
    
    //Intents
    private func updateTimeRemaining() {
        timeRemaining = Int(theSetGame.mScore.getRemainingTime())
    }
    
    func getScoringInfo() -> String {
        return theSetGame.mScore.getScoringInfo()
    }
    
    func choose(aCard: Card) {
        theSetGame.chooseCard(choice: aCard)
    }
    
    func provideHint() {
        if let card = theSetGame.provideHint() {
            hintCard = card
        } else {
            hintCard = nil
        }
    }

    func drawCards() {
        theSetGame.drawCards()
    }
    
    func newGame() {
        self.theSetGame = Game()
        drawCards()
        startTimer()
    }
}
