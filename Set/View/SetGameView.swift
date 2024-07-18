//
//  ContentView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

struct SetGameView: View {
    let theGameView:SetGame
    var body: some View {
        VStack{
            HStack{
                
                CardView(content: AnyView(OvalView(number: 3, fillingType: .open, color: .red)))
                CardView(content: AnyView(SquiggleView(number: 2, fillingType: .solid, color: .red)))
                CardView(content: AnyView(DiamondView(number: 1, fillingType: .open, color: .red)))
            }
            
            HStack{
                CardView(content: AnyView(OvalView(number: 3, fillingType: .striped, color: .red)))
                CardView(content: AnyView(SquiggleView(number: 1, fillingType: .open, color: .red)))
                CardView(content: AnyView(DiamondView(number: 3, fillingType: .solid, color: .red)))
            }
            HStack{
                CardView(content: AnyView(OvalView(number: 1, fillingType: .open, color: .red)))
                CardView(content: AnyView(SquiggleView(number: 3, fillingType: .striped, color: .red)))
                CardView(content: AnyView(DiamondView(number: 2, fillingType: .solid, color: .red)))
            }
            HStack{
                CardView(content: AnyView(OvalView(number: 2, fillingType: .solid, color: .red)))
                CardView(content: AnyView(SquiggleView(number: 3, fillingType: .open, color: .red)))
                CardView(content: AnyView(DiamondView(number: 1, fillingType: .striped, color: .red)))
            }
            
        }.padding()
        
        
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
