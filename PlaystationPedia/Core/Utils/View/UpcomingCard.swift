//
//  UpcomingCard.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/10/22.
//

import SwiftUI

struct UpcomingCard: View {
    var game: GameModel
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: game.imageUrl),
                content: { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 260, height: 130)
                    } else if phase.error != nil {
                        Color.init(UIColor.lightGray)
                            .frame(width: 260, height: 130)
                    } else {
                        Color.init(UIColor.lightGray)
                            .frame(width: 260, height: 130)
                    }
                }
            ).frame(minWidth: 260, maxHeight: 130)
                .background(Color.init(UIColor.lightGray))
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(game.title)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white)
                    if game.releaseDate != nil {
                        Text(game.releaseDate!, style: .date)
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)
                    } else {
                        Text("TBA")
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.all, 6)
            }.frame(width: 260)
                .background(
                    Color("CardColor")
                )
        }.frame(minWidth: 260, alignment: .leading)
            .background(Color.init(UIColor.lightGray))
            .asCard()
            .padding(.leading, 5)
    }
}

struct UpcomingCard_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingCard(game: dummygameData[0])
    }
}
