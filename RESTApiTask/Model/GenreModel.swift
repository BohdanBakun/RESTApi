//
//  GenreModel.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 27.05.2023.
//

import UIKit

// MARK: - GenresResponse
struct GenresResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
