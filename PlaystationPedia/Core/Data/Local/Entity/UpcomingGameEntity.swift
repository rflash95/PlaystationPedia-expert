//
//  UpcomingGameEntity.swift
//  PlaystationPedia
//
//  Created by rzamau on 30/12/22.
//

import Foundation
import RealmSwift

class UpComingGameEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var genres = ""
    @objc dynamic var publisher = ""
    @objc dynamic var developer = ""
    @objc dynamic var releaseDate = Date()
    @objc dynamic var imageUrl = ""
    @objc dynamic var platforms = ""
    @objc dynamic var ageRated = ""
    @objc dynamic var rating = ""
}
