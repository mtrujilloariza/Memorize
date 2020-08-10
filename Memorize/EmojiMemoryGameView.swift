//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Marlon Trujillo Ariza on 8/2/20.
//  Copyright © 2020 Marlon Trujillo Ariza. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
   @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Spacer()
            Score(viewModel)
            
            Text(EmojiMemoryGame.theme)
            
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                    .padding(5)
            }
                .padding()
                .foregroundColor(Color.orange)
            
            NewGame(viewModel).padding()
            Spacer()

        }
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(card.content)
            } else {
                if !card.isMactched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.5
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct Score: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    init(_ viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Score: \(viewModel.score)")
            .font(Font.largeTitle)
            .padding()
    }
}

struct NewGame: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    init(_ viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button("New Game", action: {
            self.resetGame()
        })
        .padding()
        
    }
    
    private func resetGame() {
        viewModel.randomizeTheme()
        viewModel.generateNewModel()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
