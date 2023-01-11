//
//  HomeView.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/10/22.
//

import SwiftUI

struct HomeViewScreen: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {}.onAppear {}.navigationTitle("PlaystationPedia")
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewScreen()
    }
}
