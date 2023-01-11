//
//  SearchRouter.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import SwiftUI

class SearchRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailGamePresenter(gameId: id)
      return GameDetailViewScreen(presenter: presenter)
    }
}
