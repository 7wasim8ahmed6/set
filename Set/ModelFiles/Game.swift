//
//  Game.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 17.07.24.
//

import Foundation
struct Game{
    private var mCards:[Card] = []
    private(set) var mDrawCards:[Card] = []
    private var mIsFirstDraw = true
    private(set) var mChosenCards:[Card] = []
    private(set)var mMatched:[Card] = []
    private(set) var mGameFinished = false
    private(set) var mScore = Score()
    
    init() {
        var lId = 1
        for color in Card.Color.allColors() {
            for shade in Card.Shade.allShades(){
                for shape in Card.Shape.allShapes(){
                    for multiplier in Card.Multiplier.allMultipliers(){
                        mCards.append(Card(id: lId, shape: shape, shade: shade, color: color, multiplier: multiplier))
                        lId += 1
                    }
                }
            }
        }
        mCards.shuffle()
        mScore.startTimer()
    }
    
    mutating func provideHint() -> Card? {
            let (setAvailable, hintCards) = hasSetAvailable()
            if setAvailable, !hintCards.isEmpty {
                mScore.deductPoints() // Deduct points for using a hint
                return hintCards.first // Return the first card in the found set
            }
            return nil
        }
    
    func isDeckEmpty() -> Bool
    {
        return mCards.isEmpty
    }
    
    mutating func drawCards(){
        if mIsFirstDraw {
            if mCards.count >= 12 {
                let firstDrawCards = mCards.prefix(12)
                mDrawCards.append(contentsOf: firstDrawCards)
                mCards.removeFirst(12)
                mIsFirstDraw = false
            }
        } else {
            if mCards.count >= 3 {
                let (isSetAvailable, _) = hasSetAvailable()
                if isSetAvailable{
                    mScore.deductPoints()
                }
                
                if mChosenCards.count == 3
                {
                    replaceDrawCardsIfChoiceFull()
                }
                else
                {
                    let additionalDrawCards = mCards.prefix(3)
                    mDrawCards.append(contentsOf: additionalDrawCards)
                    mCards.removeFirst(3)
                }
            }
        }
    }
    
    func getWelcomeMessage() -> String {
        return "Welcome to the Set Game! Get ready to test your pattern recognition skills."
    }
    
    func hasSetAvailable() -> (Bool, [Card]) {
        let size = mDrawCards.count

        guard size >= 3 else {
            return (false, [])
        }

        for i in 0..<size {
            for j in (i + 1)..<size {
                for k in (j + 1)..<size {
                    let card1 = mDrawCards[i]
                    let card2 = mDrawCards[j]
                    let card3 = mDrawCards[k]

                    // Skip cards that are already in mMatched
                    if mMatched.contains(where: { $0.id == card1.id || $0.id == card2.id || $0.id == card3.id }) {
                        continue
                    }

                    if makeMatch(first: card1, second: card2, third: card3) {
                        return (true, [card1, card2, card3])
                    }
                }
            }
        }
        return (false, [])
    }
    
    private func findChosenCardIndexInDrawn(aCard:Card) -> Int?
    {
        return mDrawCards.firstIndex(where: {
            $0.id == aCard.id
        })
    }
    
    private mutating func replaceDrawCardsIfChoiceFull()
    {
        if mChosenCards.count == 3
        {
            print("3 Choosen from Draw cards, \(mChosenCards[0]), \(mChosenCards[1]), \(mChosenCards[2])")
            let lIdOfFirstChoice = mChosenCards[0].id
            //If there was a match, the same cards will be put into mMatched
            if let _ = mMatched.first(where: {$0.id == lIdOfFirstChoice}){
                //Replace the same index draw cards with new ones from mCards
                print("3 Choosen cards were matched, Trying to replace matched cards")
                for card in mChosenCards{
                    if let indexInDrawn = findChosenCardIndexInDrawn(aCard: card){
                        if !mCards.isEmpty
                        {
                            let newCard = mCards.removeFirst()
                            mDrawCards[indexInDrawn] = newCard
                        }
                        else
                        {
                            mDrawCards.remove(at: indexInDrawn)
                        }
                    }
                }
            }
            //clear the choice
            mChosenCards.removeAll(keepingCapacity: true)
            //Clear matched cards
            mMatched.removeAll(keepingCapacity: true)
            print("Cleared mChoosen indices and mMatched")
        }
    }
    
    private func isMatchedCardSelected(selectedIndex:Int) -> Bool
    {
        return mMatched.contains(where: {$0.id == mDrawCards[selectedIndex].id})
    }
    
    private mutating func addOrRemoveChoice(aCard:Card)
    {
        if let lIndex = mChosenCards.firstIndex(where: {
            $0.id == aCard.id
        }){
            mChosenCards.remove(at: lIndex)
        }
        else
        {
            mChosenCards.append(aCard)
        }
    }
    
    private mutating func makeMatch() ->Bool//return true if match was made
    {
        if makeMatch(first: mChosenCards[0], second: mChosenCards[1], third: mChosenCards[2]){
            mMatched.append(mChosenCards[0])
            mMatched.append(mChosenCards[1])
            mMatched.append(mChosenCards[2])
            return true
        }
        else
        {
            return false
        }
    }
    
    func makeMatch(first:Card, second:Card, third:Card) -> Bool{
        if first.id == second.id || second.id == third.id || third.id == first.id{
            return false
        }
        
        if (first.color != second.color && second.color != third.color && first.color != third.color) || (first.color == second.color && second.color == third.color)
        {
            if (first.shade != second.shade && second.shade != third.shade && first.shade != third.shade) || (first.shade == second.shade && second.shade == third.shade)
            {
                if (first.shape != second.shape && second.shape != third.shape && first.shape != third.shape) || (first.shape == second.shape && second.shape == third.shape)
                {
                    if (first.multiplier != second.multiplier && second.multiplier != third.multiplier && first.multiplier != third.multiplier) || (first.multiplier == second.multiplier && second.multiplier == third.multiplier)
                    {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    mutating func chooseCard(choice:Card){
        
        guard let indexOfSelectedCard = mDrawCards.firstIndex(where: {$0.id == choice.id}) else{
            return
        }
        if(isMatchedCardSelected(selectedIndex: indexOfSelectedCard))//will be run on 4th choice
        {
            print("Selected is a matched card")
            return
        }
        replaceDrawCardsIfChoiceFull()//Will run on 4th choice.After this if there were 3 choosen, choosen will be empty.
        //Now it can be first or second selection or 3rd selection
        addOrRemoveChoice(aCard: choice)
        
        //If 3 choices are made, try make a match if possible
        if mChosenCards.count == 3{
            if(makeMatch()){
                mScore.addCorrectPoints()
                print("\(mChosenCards[0])\n\(mChosenCards[1])\n\(mChosenCards[2]) make a match ")
                if(mDrawCards.count == 3)
                {
                    mGameFinished = true
                }
            }
            else
            {
                mScore.deductPoints()
                print("\(mChosenCards[0])\n\(mChosenCards[1])\n\(mChosenCards[2]) fail to make a match ")
                
            }
        }
        
    }
}
