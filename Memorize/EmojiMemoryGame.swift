//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Marlon Trujillo Ariza on 8/3/20.
//  Copyright © 2020 Marlon Trujillo Ariza. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static var themes = ["Halloween", "Sports", "Animals"]
    static var theme: String = themes.randomElement()!
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = EmojiMemoryGame.getEmojis(theme)
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            return emojis![pairIndex]
        }
    }
    
    static func getEmojis(_ theme: String) -> [String]? {
        switch theme {
            case "Halloween":
                return ["👻", "🎃", "🕷", "☠️", "🍬", "🙀", "🍫", "🍭", "😈"].shuffled()
            case "Sports":
                return ["🎾", "🏀", "⚾️", "🏈", "🏓", "🏒", "🏸", "⚽️", "🥍"].shuffled()
            case "Animals":
                return ["🦙", "🦛", "🦮", "🦨", "🦜", "🦧", "🦓", "🦦", "🦒"].shuffled()
            default:
                return nil
        }
    }

    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func randomizeTheme() {
        EmojiMemoryGame.theme = EmojiMemoryGame.themes.randomElement()!
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
