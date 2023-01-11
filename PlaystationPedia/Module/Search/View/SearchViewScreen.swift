//
//  SearchView.swift
//  PlaystationPedia
//
//  Created by rzamau on 13/10/22.
//

import SwiftUI

struct SearchViewScreen: View {
    @ObservedObject var presenter: SearchPresenter

    var body: some View {
        NavigationView {
            List {
                if presenter.games.isEmpty {
                    Spacer()
                        .padding(.vertical, 16.0)
                    HStack {
                        Spacer()
                        Text("Your search was not found")
                            .fontWeight( .bold)
                            .font(.subheadline)
                            .padding(.leading, 16)
                            .padding(.top, 16)
                        Spacer()
                    }
                } else {
                    ForEach(presenter.games, id: \.id) { game in
                        self.presenter.linkBuilder(for: game.id) {
                            Text(game.title)
                        }
                    }
                }
            }
            .searchable(text: $presenter.searchText).onChange(of: presenter.searchText) { _ in
                if presenter.searchText.count >= 3 {
                    Task { presenter.searchGames()}
                }
            }
            .navigationTitle("Find Games")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewScreen(presenter: SearchPresenter())
    }
}
