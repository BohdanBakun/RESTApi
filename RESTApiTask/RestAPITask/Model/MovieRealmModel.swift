//
//  MovieRealmModel.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 01.06.2023.
//

import RealmSwift

class MovieRealmModel: Object {
    @Persisted var title = ""
    // @Persisted var genreIDS: List<Int>

    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        // case genreIDS = "genre_ids"
    }
}
