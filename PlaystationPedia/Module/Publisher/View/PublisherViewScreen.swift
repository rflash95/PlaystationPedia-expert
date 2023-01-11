//
//  PublisherViewScreen.swift
//  PlaystationPedia
//
//  Created by rzamau on 06/11/22.
//

import SwiftUI

struct PublisherViewScreen: View {
    @ObservedObject var presenter: PublisherPresenter
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if presenter.loadingState {
                        Spacer()
                            .padding(.vertical, 16.0)
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        ScrollView(.horizontal, showsIndicators: true) {
                            VStack(spacing: 8) {
                                ForEach(presenter.publishers, id: \.id) { publisher in
                                    self.presenter.linkBuilder(for: publisher.id) {
                                        PublisherCard(publisher: publisher)
                                    }
                                }
                            }.frame(minHeight: 200, maxHeight: .greatestFiniteMagnitude)
                        }.frame(minHeight: 200)
                    }
                }.navigationTitle("Publishers")
            }
        }.preferredColorScheme(.dark)
            .onAppear {
                Task { presenter.getPublishers() }
            }
            .refreshable {
                Task { presenter.getPublishers() }
            }
    }
}

struct PublisherViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublisherViewScreen(presenter: PublisherPresenter())
    }
}
