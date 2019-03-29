//
//  Constants.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let imagePathURL = "https://image.tmdb.org/t/p/"
        static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
