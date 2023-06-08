//
//  File.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 07.06.2023.
//

import Foundation

class UserDefaultsController {
    let defaults = UserDefaults.standard
    let key = "movies"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func save(movies: [Movie]) {
        if let data = try? encoder.encode(movies) {
            defaults.set(data, forKey: key)
        }
    }
    
    func load() -> [Movie] {
        guard
            let data = defaults.data(forKey: key),
            let movies = try? decoder.decode([Movie].self, from: data)
        else { return [] }
        
        return [Movie.init(adult: nil, backdropPath: nil, id: nil, title: "Cached", originalLanguage: nil, originalTitle: nil, overview: nil, posterPath: nil, mediaType: nil, genreIDS: nil, popularity: nil, releaseDate: nil, video: nil, voteAverage: nil, voteCount: nil)] + movies
    }
}
