//
//  Movie.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import Foundation

struct MovieRoot: Codable {
    var results: [Movie]
    var page: Int
    let totalPages: Int
}

struct Movie: Codable {
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let title: String?
    var posterURL: URL? {
        return URL(string: K.ProductionServer.imagePathURL + "w500" + (posterPath ?? ""))
    }
    var backdropURL: URL? {
        return URL(string: K.ProductionServer.imagePathURL + "original" +  (backdropPath ?? ""))
    }
}

extension MovieRoot {
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case title
//        case posterURL
//        case backdropURL
    }
}
