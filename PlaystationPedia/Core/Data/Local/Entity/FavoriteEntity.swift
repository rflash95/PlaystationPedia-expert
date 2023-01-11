//
//  FavoriteGame.swift
//  PlaystationPedia
//
//  Created by rzamau on 05/11/22.
//

import Foundation
import RealmSwift

class FavoriteEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var rating = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var releaseDate = Date()
    override class func primaryKey() -> String? { return "id" }
}
