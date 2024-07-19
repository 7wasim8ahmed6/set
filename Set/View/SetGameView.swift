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
            AspectVGrid(items: theGameView.theSetGame.mDrawCards, aspectRatio: 2/3, content: {card in
                
                CardView(content: AnyView(SquiggleView(number: 3, fillingType: .solid, color: .red))).aspectRatio(2/3, contentMode: .fit)
            })
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
