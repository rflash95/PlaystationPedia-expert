//
//  HomeRouter.swift
//  PlaystationPedia
//
//  Created by rzamau on 06/01/23.
//

import Foundation
import SwiftUI

class HomeRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailGamePresenter(gameId: id)
      return GameDetailViewScreen(presenter: presenter)
    }
}
