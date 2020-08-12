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
           
            Text("Score: \(viewModel.score)")
                .font(Font.largeTitle)
                .padding()
            
            Text(EmojiMemoryGame.theme)
            
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.55)){
                        self.viewModel.choose(card: card)
                    }
                }
                    .padding(5)
            }
                .padding()
                .foregroundColor(Color.orange)
            
            Button("New Game", action: {
                withAnimation(.easeInOut){
                    self.viewModel.randomizeTheme()
                    self.viewModel.resetGame()
                }
            }).padding()
            
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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMactched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(155-90), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMactched ? 360: 0))
                    .animation(card.isMactched ? Animation.linear(duration: 1.5).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
