//
//  Resolver.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/01/23.
//

class Resolver {
    static let shared = Resolver()
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
