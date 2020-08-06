//
//  MemoryGame.swift
//  Memorize
//
//  Created by Marlon Trujillo Ariza on 8/3/20.
//  Copyright © 2020 Marlon Trujillo Ariza. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        print("card chosen: \(self.cards[chosenIndex])")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        
        return 0 // TODO: bogus!
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMactched: Bool = false
        var content: CardContent
        var id: Int
    }
}
