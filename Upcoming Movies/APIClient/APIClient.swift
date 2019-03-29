//
//  APIClient.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import Alamofire

class APIClient {
    private static func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping(Result<T>) -> Void) {
        AF.request(route).responseDecodable(decoder: decoder) { (response: DataResponse<T>) in
                debugPrint(response)
                completion(response.result)
        }
    }

    static func searchMovies(page: Int, query: String, completion: @escaping(Result<MovieRoot>) -> Void) {
        performRequest(route: APIRouter.findMovies(page: page, query: query), completion: completion)
    }
    
    static func getUpcomingMovies(page: Int, completion: @escaping(Result<MovieRoot>) -> Void) {
        performRequest(route: APIRouter.findUpcomingMovies(page: page), completion: completion)
    }
    
    static func getGenres(completion: @escaping(Result<GenreRoot>) -> Void) {
        performRequest(route: APIRouter.genres, completion: completion)
    }
}

