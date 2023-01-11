//
//  PublisherEntity.swift
//  PlaystationPedia
//
//  Created by rzamau on 30/12/22.
//

import Foundation
import RealmSwift

class PublisherEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var gamesCount = 0
    @objc dynamic var imageUrl = ""
    @objc dynamic var desc = ""
    override class func primaryKey() -> String? { return "id" }
}
