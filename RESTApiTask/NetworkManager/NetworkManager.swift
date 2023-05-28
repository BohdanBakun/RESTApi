//
//  File.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 27.05.2023.
//

import UIKit
import Alamofire

class NetworkManager {
    
    let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDlmODBjMTc0NGQ0MmY2NGYwZDM0Y2U5ZmExZGViMCIsInN1YiI6IjY0NjhjOTM3MDA2YjAxMDE2ODRiOWMzYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m2vezNARQSURv4sQpV8-VxYqjU7CPmjhI5cmHkCwCzY"
    ]
    
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    func loadMoviesData() async throws -> [Results] {
        
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=7d9f80c1744d42f64f0d34ce9fa1deb0")!
        
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let sessionResponse = try await session.data(for: request)
        let moviesResponse = try decoder.decode(Movies.self, from: sessionResponse.0)

        return moviesResponse.results
    }
    
    func loadGenresData() async throws -> [Genre] {
        
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en")!
        
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let sessionResponse = try await session.data(for: request)
        let genresResponse = try decoder.decode(GenresResponse.self, from: sessionResponse.0)
        
        return genresResponse.genres
    }
}
