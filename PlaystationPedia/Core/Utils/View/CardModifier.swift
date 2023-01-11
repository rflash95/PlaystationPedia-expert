//
//  CardModifier.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/10/22.
//
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

extension View {
  func asCard() -> some View {
    modifier(CardModifier())
  }
}
