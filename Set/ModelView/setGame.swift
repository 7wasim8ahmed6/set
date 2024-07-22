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

    func provideHint() {
        if let card = theSetGame.provideHint() {
            hintCard = card
        } else {
            hintCard = nil
        }
    }
    private var timer: AnyCancellable?

    init() {
        self.theSetGame = Game()
        theSetGame.drawCards()
        startTimer()
    }

    func drawCards() {
        theSetGame.drawCards()
    }

    func newGame() {
        self.theSetGame = Game()
        drawCards()
        startTimer()
    }

    func choose(aCard: Card) {
        theSetGame.chooseCard(choice: aCard)
    }

    func interpretCard(aCard: Card) -> CardView {
        let filling = interpretShade(aCard.shade)
        let numbers = interpretMultiplier(aCard.multiplier)
        let color = interpretColor(aCard.color)
        let chosen = theSetGame.mChosenCards.contains(where: { $0.id == aCard.id })
        let matchedCard = theSetGame.mMatched.contains(where: { $0.id == aCard.id })

        if aCard.shape == .diamond {
            return CardView(content: AnyView(DiamondView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matchedCard)
        } else if aCard.shape == .oval {
            return CardView(content: AnyView(OvalView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matchedCard)
        } else {
            return CardView(content: AnyView(SquiggleView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matchedCard)
        }
    }

    private func interpretShade(_ shade: Card.Shade) -> FillingType {
        switch shade {
        case .shaded:
            return .solid
        case .open:
            return .open
        case .striped:
            return .striped
        }
    }

    private func interpretMultiplier(_ multiplier: Card.Multiplier) -> Int {
        switch multiplier {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }

    private func interpretColor(_ aColor: Card.Color) -> Color {
        switch aColor {
        case .green:
            return Color.green
        case .pink:
            return Color.pink
        case .purple:
            return Color.purple
        }
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

    private func updateTimeRemaining() {
        timeRemaining = Int(theSetGame.mScore.getRemainingTime())
    }
    
    func getScoringInfo() -> String {
        return theSetGame.mScore.getScoringInfo()
        }
}
