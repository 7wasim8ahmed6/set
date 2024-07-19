//
//  setGame.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import Foundation

class SetGame
{
    private(set) var theSetGame:Game
    init() {
        self.theSetGame = Game()
        let _ = theSetGame.drawCards()
    }
}
