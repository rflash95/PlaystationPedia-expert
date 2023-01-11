//
//  FavoriteRouter.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailGamePresenter(gameId: id)
      return GameDetailViewScreen(presenter: presenter)
    }
}
