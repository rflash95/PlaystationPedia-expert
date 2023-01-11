//
//  Inject.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/01/23.
//

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}
