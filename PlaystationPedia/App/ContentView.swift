//
//  ContentView.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/10/22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeViewScreen(presenter: HomePresenter())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PublisherViewScreen(presenter: PublisherPresenter())
                .tabItem {
                    Label("Publisher", systemImage: "diamond.fill")
                }
            SearchViewScreen(presenter: SearchPresenter())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            FavoriteViewScreen(presenter: FavoritePresenter())
                .tabItem {
                    Label("Favorite", systemImage: "heart.circle.fill")
                }
            ProfileViewScreen(presenter: ProfilePresenter())
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
