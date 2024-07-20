//
//  setGame.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

class SetGame: ObservableObject
{
    @Published private(set) var theSetGame:Game
    init() {
        self.theSetGame = Game()
        let _ = theSetGame.drawCards()
    }
    
    func drawCards()
    {
        let _ = theSetGame.drawCards()
    }
    
    func newGame(){
        self.theSetGame = Game()
        drawCards()
    }
    
    func choose(aCard:Card)
    {
        theSetGame.chooseCard(choice: aCard)
    }
    
    func interpretCard(aCard:Card) -> CardView{
        let filling = interpretShade(aCard.shade)
        let numbers = interpretMultiplier(aCard.multiplier)
        let color = interpretColor(aCard.color)
        if aCard.shape == .diamond
        {
            return CardView(content: AnyView(DiamondView(number: numbers, fillingType: filling, color: color)))
        }
        else if aCard.shape == .oval
        {
            return CardView(content: AnyView(OvalView(number: numbers, fillingType: filling, color: color)))
        }
        else
        {
            return CardView(content: AnyView(SquiggleView(number: numbers, fillingType: filling, color: color)))
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
    private func interpretColor(_ aColor:Card.Color) -> Color
    {
        switch aColor{
        case .green:
            return Color.green
        case .pink:
            return Color.pink
        case .purple:
            return Color.purple
        }
    }
}
