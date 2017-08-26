//
//  Routers.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 13/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire


protocol RouterRequest: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var params: [String: String]? { get }
}

extension RouterRequest {
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        var finalParams = defaultParams
        if let params = params {
            params.forEach { finalParams[$0] = $1 }
        }
        urlRequest = try URLEncoding.default.encode(urlRequest, with: finalParams)
        return urlRequest
    }
    
    
    var params: [String: String]? { return nil }
    var method: HTTPMethod { return .get }
    
    var defaultParams: [String: String] {
        return [
            "api_key": Constants.apiKey,
            "language": Constants.apiLanguage
        ]
    }
    
}

struct MovieRouter {
    
    struct Detail: RouterRequest {
        let movieId: Int
        
        var path: String { return "movie/\(movieId)" }
        var params: [String : String]? {
            return [
                "include_image_language": Constants.apiImageLanguage,
                "append_to_response": "credits,images,videos,reviews"
            ]
        }
    }
    
    struct Search: RouterRequest {
        let query: String
        
        var path: String { return "search/movie" }
        var params: [String: String]? {
            return ["query":query]
        }
    }
    
    struct NowPlaying: RouterRequest {
        var path: String { return "movie/now_playing" }
        var params: [String : String]? {
            return ["region":Constants.apiRegion]
        }
    }
    
    struct Popular: RouterRequest {
        var path: String { return "movie/popular" }
        var params: [String : String]? {
            return ["region":Constants.apiRegion]
        }
    }
    
    struct TopRated: RouterRequest {
        var path: String { return "movie/top_rated" }
        var params: [String : String]? {
            return ["region":Constants.apiRegion]
        }
    }
    
    struct Genres: RouterRequest {
        var path: String { return "genre/movie/list" }
    }
    
    
}

struct ActorRouter {
    
    struct Detail: RouterRequest {
        let actorId: Int
    
        var path: String { return "person/\(actorId)" }
        var params: [String : String]? {
            return [
                "include_image_language": Constants.apiImageLanguage,
                "append_to_response": "credits"
            ]
        }
    }

    struct Search: RouterRequest {
        let query: String
    
        var path: String { return "search/person" }
        var params: [String: String]? {
            return ["query":query]
        }
    }
    
    struct Popular: RouterRequest {
        var path: String { return "person/popular"}
        var params: [String: String]? {
            return ["region":Constants.apiRegion]
        }
    }
}
