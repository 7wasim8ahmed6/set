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
            
            OvalView(number: 1, fillingType: .open, color: .red)
            DiamondView(number: 1, fillingType: .open, color: .red)
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
