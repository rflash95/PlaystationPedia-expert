//
//  FavoriteViewScreen.swift
//  PlaystationPedia
//
//  Created by rzamau on 03/11/22.
//

import SwiftUI

struct FavoriteViewScreen: View {
    @ObservedObject var presenter: FavoritePresenter

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if presenter.favorites.isEmpty {
                        Spacer()
                            .padding(.vertical, 16.0)
                        HStack {
                            Spacer()
                            Text("Your favorite game is empty. Just press love button in the game detail page")
                                .fontWeight( .bold)
                                .font(.subheadline)
                                .padding(.leading, 16)
                                .padding(.top, 16)
                            Spacer()
                        }
                    } else {
                        ScrollView(.horizontal, showsIndicators: true) {
                            VStack(spacing: 8) {
                                ForEach(presenter.favorites, id: \.id) { favorite in
                                    self.presenter.linkBuilder(for: favorite.id) {
                                        GameFavoriteCard(favorite: favorite)
                                    }
                                }
                            }.frame(minHeight: 200, maxHeight: .greatestFiniteMagnitude)
                        }.frame(minHeight: 200)
                    }
                }.navigationTitle("Favorites ")
            }
        }.preferredColorScheme(.dark)
            .onAppear{
                presenter.getFavorites()
            }
            .refreshable {
                presenter.getFavorites()
            }
    }
}

struct FavoriteViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteViewScreen(presenter: FavoritePresenter())
    }
}
