//
//  PublisherDetailViewScreen.swift
//  PlaystationPedia
//
//  Created by rzamau on 06/11/22.
//

import SwiftUI

struct PublisherDetailViewScreen: View {
    @ObservedObject var presenter: DetailPublisherPresenter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if presenter.publisher == nil {
                    Spacer()
                        .padding(.vertical, 16.0)
                    HStack(alignment: VerticalAlignment.center) {
                        Text("Loading data ...")
                            .font(.system(size: 12))
                            .foregroundColor(Color.white)
                        ProgressView()
                    }
                } else {
                    AsyncImage(
                        url: URL(string: presenter.publisher!.imageUrl),
                        content: { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .frame(height: 200)
                                    .clipped()
                            } else if phase.error != nil {
                                Color.init(UIColor.lightGray)
                                    .frame( height: 200)
                            } else {
                                Color.init(UIColor.lightGray)
                                    .frame(height: 200)
                            }
                        }).frame(maxWidth: .infinity, maxHeight: 200)
                    VStack(alignment: .leading) {
                        Group {
                            Spacer()
                            Text("About Publisher")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Text(presenter.publisher!.description.isEmpty ?
                                 "Description not available" : presenter.publisher!.description)
                                .font(.system(size: 13))
                            Spacer()
                            Spacer()
                        }
                    }
                }
            }
        }.navigationTitle(presenter.publisher?.name ?? "Please wait ...")
    }
}
struct PublisherDetailViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublisherDetailViewScreen(presenter: DetailPublisherPresenter(publisherId: 308))
    }
}
