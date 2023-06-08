//
//  Movie.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 01.06.2023.
//

import UIKit

//struct Movie: Codable {
//    let title: String
//    //let genreIDS: [Int]
//
//    enum CodingKeys: String, CodingKey {
//        case title = "original_title"
//        //case genreIDS = "genre_ids"
//    }
//}
//
//struct MoviesResponse: Codable {
//    let results: [Movie]
//}


// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle, overview, posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
