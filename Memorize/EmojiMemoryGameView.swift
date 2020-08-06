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
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
            
        }
        .aspectRatio(2/3, contentMode: .fit)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
