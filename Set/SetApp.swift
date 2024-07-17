//
//  SetApp.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import SwiftUI

@main
struct SetApp: App {
    private let theGame = SetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(theGameView: theGame)
        }
    }
}
