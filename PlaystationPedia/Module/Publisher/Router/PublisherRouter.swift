//
//  PublisherRouter.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import SwiftUI

class PublisherRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailPublisherPresenter(publisherId: id)
      return PublisherDetailViewScreen(presenter: presenter)
    }
}
