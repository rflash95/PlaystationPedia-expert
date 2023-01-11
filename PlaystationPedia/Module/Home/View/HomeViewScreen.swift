//
//  HomeView.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/10/22.
//

import SwiftUI

struct HomeViewScreen: View {
    @ObservedObject var presenter: HomePresenter

    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Upcoming Games")
                        .fontWeight( .bold)
                        .font(.title)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    if presenter.loadingUpcomingGamesState {
                        Spacer()
                            .padding(.vertical, 16.0)
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(spacing: 8) {
                                ForEach(self.presenter.upcomingGames, id: \.id) { game in
                                    self.presenter.linkBuilder(for: game.id) {
                                        UpcomingCard(game: game)
                                    }
                                }
                            }.frame(minHeight: 200, maxHeight: .greatestFiniteMagnitude)
                        }.frame(minHeight: 200)
                    }
                    Text("What are you looking for?")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    Text("Explore by genres and find your game")
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    HStack(spacing: 16) {
                        Button {
                            presenter.genreSelected = "action"
                            Task {self.presenter.getGameByGenre() }
                        } label: {
                            Text("Action")
                        }.buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .foregroundColor(.white)
                        Button {
                            presenter.genreSelected  = "indie"
                            Task {self.presenter.getGameByGenre() }
                        } label: {
                            Text("Indie")
                        }.buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .foregroundColor(.white)
                        Button {
                            presenter.genreSelected  = "shooter"
                            Task {self.presenter.getGameByGenre() }
                        } label: {
                            Text("Shooter")
                        }.buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .foregroundColor(.white)
                    }.padding(.leading, 16)
                    Spacer()
                    Spacer()
                    if presenter.loadingGamesByGenreState {
                        Spacer()
                            .padding(.vertical, 16.0)
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                                ForEach( presenter.gameByGenre, id: \.id) { game in
                                    self.presenter.linkBuilder(for: game.id) {
                                        GameCard(game: game)
                                    }
                                }
                            }.padding(.horizontal)
                        }
                    }
                    Spacer()
                }.navigationTitle("PlaystationPedia")
            }
        }.preferredColorScheme(.dark)
            .refreshable {
                self.presenter.refresh()
                Task {
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewScreen(presenter: HomePresenter())
    }
}
