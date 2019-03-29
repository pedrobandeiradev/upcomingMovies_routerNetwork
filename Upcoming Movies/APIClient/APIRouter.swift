//
//  APIRouter.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case findMovies(page: Int, query: String)
    case findUpcomingMovies(page: Int)
    case genres
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var path: String {
        switch self {
        case .findMovies:
            return "search/movie"
        case .findUpcomingMovies:
            return "movie/upcoming"
        case .genres:
            return "genre/movie/list"
        }
    }
    
    private var queryParameters: String {
        switch self {
        case .findMovies(let page, let query):
            return "&page=\(page)&query=\(query)"
        case .findUpcomingMovies(let page):
            return "&page=\(page)"
        default:
            return ""
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = try K.ProductionServer.baseURL.asURL()
        let apiKey = K.ProductionServer.apiKey
        let query = queryParameters.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let strURL = "\(baseURL)\(path)?api_key=\(apiKey)\(query)"
        let url = URL(string: strURL)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
        return urlRequest
    }
}
