//
//  Card.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import Foundation
struct Card :Identifiable, Equatable{
    let id: Int
    let shape:Shape
    let shade:Shade
    let color:Color
    let multiplier:Multiplier
    
    
    enum Multiplier:CaseIterable{
        case one
        case two
        case three
        static func allMultipliers() ->[Multiplier]
        {
            return Array(Multiplier.allCases)
        }
    }
    
    enum Shade:CaseIterable{
        case shaded
        case open
        case striped
        static func allShades() -> [Shade]
        {
            return Array(Shade.allCases)
        }
    }
    
    enum Shape:CaseIterable{
        case oval
        case squiggle
        case diamond
        static func allShapes()->[Shape]
        {
            return Array(Shape.allCases)
        }
    }
    
    
    enum Color:CaseIterable {
        case green
        case pink
        case purple
        
        var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            switch self {
            case .green:
                return (red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
            case .pink:
                return (red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0)
            case .purple:
                return (red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
            }
        }
        
        static func allColors()->[Color]
        {
            return Array(Color.allCases)
        }
    }
}
