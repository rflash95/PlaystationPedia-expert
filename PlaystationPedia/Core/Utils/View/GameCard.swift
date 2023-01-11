//
//  GameCard.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/10/22.
//

import SwiftUI

struct GameCard: View {
    var game: GameModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                AsyncImage(
                    url: URL(string: game.imageUrl),
                    content: { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                        } else if phase.error != nil {
                            Color.init(UIColor.lightGray)
                                .frame(width: 150, height: 150)
                        } else {
                            Color.init(UIColor.lightGray)
                                .frame(width: 150, height: 150)
                        }

                    }
                ).frame(minHeight: 150)
                    .background(Color.init(UIColor.lightGray))
            }.frame(minWidth: 150, alignment: .leading)
                .background(Color.init(UIColor.lightGray))
                .asCard()
            Text(game.title)
                .lineLimit(1)
                .font(.system(size: 12))
                .foregroundColor(Color.white)
            HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .font(.system(size: 8))
                .foregroundColor(Color.white)

            Text("\(game.rating)")
                .font(.system(size: 8))
                .foregroundColor(Color.white)
            }
        }
    }
}

    struct GameCard_Previews: PreviewProvider {
        static var previews: some View {
            GameCard(game: dummygameData[0])
        }
    }
