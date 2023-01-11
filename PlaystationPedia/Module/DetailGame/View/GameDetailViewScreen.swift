//
//  GameDetailView.swift
//  PlaystationPedia
//
//  Created by rzamau on 12/10/22.
//

import SwiftUI

struct GameDetailViewScreen: View {
    var gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var presenter: DetailGamePresenter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if presenter.loadingState {
                    Spacer()
                        .padding(.vertical, 16.0)
                    HStack(alignment: VerticalAlignment.center) {
                        Text("Loading data ...")
                            .font(.system(size: 12))
                            .foregroundColor(Color.white)
                        ProgressView()
                    }
                } else if presenter.game == nil {
                    Spacer()
                        .padding(.vertical, 16.0)
                    HStack(alignment: VerticalAlignment.center) {
                        Text("Data not found")
                            .font(.system(size: 12))
                            .foregroundColor(Color.white)
                    }
                } else {
                    AsyncImage(
                        url: URL(string: presenter.game?.imageUrl ?? ""),
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
                            Text("About This Game")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Text(presenter.game?.description.isEmpty == true ?
                                 "Description not available" : presenter.game!.description)
                                .font(.system(size: 13))
                            Spacer()
                            Spacer()
                        }
                        Group {
                            Grid(alignment: .leading, horizontalSpacing: 60, verticalSpacing: 10) {
                                GridRow {
                                    VStack(alignment: .leading) {
                                        Text("Platform")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        Text(presenter.game!.platforms)
                                            .font(.system(size: 12))
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Genre")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        Text(presenter.game!.genres)
                                            .font(.system(size: 12))
                                    }
                                }
                                GridRow {
                                    VStack(alignment: .leading) {
                                        Text("Release Date")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        if presenter.game!.releaseDate !=  nil {
                                            Text(presenter.game!.releaseDate!, style: .date)
                                                .font(.system(size: 12))
                                        } else {
                                            Text("TBA")
                                                .font(.system(size: 12))
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Developer")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        Text(presenter.game!.developer)
                                            .font(.system(size: 12))
                                    }
                                }
                                GridRow {
                                    VStack(alignment: .leading) {
                                        Text("Age Rated")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        Text(presenter.game!.ageRated)
                                            .font(.system(size: 12))
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Publisher")
                                            .font(.system(size: 16))
                                            .fontWeight(.medium)
                                        Text(presenter.game!.publisher)
                                            .font(.system(size: 12))
                                    }
                                }
                            }
                        }
                    }.padding(.all, 12)
                }
            }
        }.navigationTitle(self.presenter.game?.title ?? "Please wait ...")
            .toolbar {
                Button {
                    presenter.isFavorite = !presenter.isFavorite
                    if presenter.isFavorite {
                        presenter.addFavorite()
                    } else {
                            presenter.deleteFavorite()
                        }
                } label: {
                    Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                }
            }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailViewScreen(presenter: DetailGamePresenter(gameId: 3498))
    }
}
