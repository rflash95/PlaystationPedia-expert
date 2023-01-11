//
//  GamFavoriteCard.swift
//  PlaystationPedia
//
//  Created by rzamau on 04/11/22.
//

import SwiftUI

struct GameFavoriteCard: View {
    var favorite: FavoriteModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                AsyncImage(
                    url: URL(string: favorite.imageUrl),
                    content: { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                        } else if phase.error != nil {
                            Color.init(UIColor.lightGray)
                                .frame(width: 400, height: 250)
                        } else {
                            Color.init(UIColor.lightGray)
                                .frame(width: 400, height: 250)
                        }
                    }
                ).frame(maxWidth: .infinity, maxHeight: 250)
                    .background(Color.init(UIColor.lightGray))
            }.frame(alignment: .leading)
                .background(Color.init(UIColor.lightGray))
                .asCard()
            Text(favorite.title )
                .lineLimit(1)
                .font(.system(size: 18))
                .foregroundColor(Color.white)
            HStack(spacing: 2) {
                Image(systemName: "star.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                Text(favorite.rating )
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
            }
        }
    }
}
