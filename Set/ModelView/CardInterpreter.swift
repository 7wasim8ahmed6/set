//
//  CardInterpreter.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 09.08.24.
//

import SwiftUI

struct CardInterpreter {
    static func interpretCard(_ aCard: Card, chosen: Bool, matched: Bool) -> CardView {
        let filling = interpretShade(aCard.shade)
        let numbers = interpretMultiplier(aCard.multiplier)
        let color = interpretColor(aCard.color)
        
        switch aCard.shape {
        case .diamond:
            return CardView(content: AnyView(DiamondView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matched)
        case .oval:
            return CardView(content: AnyView(OvalView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matched)
        case .squiggle:
            return CardView(content: AnyView(SquiggleView(number: numbers, fillingType: filling, color: color)), chosen: chosen, matched: matched)
        }
    }
    
    private static func interpretShade(_ shade: Card.Shade) -> FillingType {
        switch shade {
        case .shaded:
            return .solid
        case .open:
            return .open
        case .striped:
            return .striped
        }
    }
    
    private static func interpretMultiplier(_ multiplier: Card.Multiplier) -> Int {
        switch multiplier {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }
    
    private static func interpretColor(_ aColor: Card.Color) -> Color {
        switch aColor {
        case .green:
            return Color.green
        case .pink:
            return Color.pink
        case .purple:
            return Color.purple
        }
    }
}
