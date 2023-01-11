//
//  PublisherCard.swift
//  PlaystationPedia
//
//  Created by rzamau on 06/11/22.
//

import SwiftUI

struct PublisherCard: View {
    var publisher: PublisherModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                AsyncImage(
                    url: URL(string: publisher.imageUrl),
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
            Text(publisher.name)
                .lineLimit(1)
                .font(.system(size: 18))
                .foregroundColor(Color.white)
            HStack(spacing: 2) {
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                Text("Games Count : \(publisher.gamesCount)")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct PublisherCard_Previews: PreviewProvider {
    static var previews: some View {
        PublisherCard(publisher: dummyPublishers[0])
    }
}
