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
    // it would be better to move this to some kind of Constants struct/enum
    var baseURLString: String { return "https://api.themoviedb.org/3" }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = params {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
    
    
    var params: [String: String]? { return nil }
    var method: HTTPMethod { return .get }
    
}


let apiKey = "c361d02c5dfff7d63adfafbb344088f9"

struct MovieRouter {
    
    // items below are actual routes. Please note, that you always need to create new struct for each request, but since structs are very light-weight it shouldn't be a problem
    struct SearchAll: RouterRequest {
        var path: String { return "/search/movie?api_key=\(apiKey)&language=en-US&page=1&include_adult=false" }
    }
    
    struct GetMovieBasicInfo: RouterRequest {
    // Use for genre, picture, plot, creators and actors, trailers, image gallery and reviews
        let movieId: String
        
        var path: String { return "/movie/\(movieId)?api_key=\(apiKey)&append_to_response=credits,images,videos,reviews&language=en-US&include_image_language=en,null" }
        
    }
}

struct ActorRouter {
    
    // items below are actual routes. Please note, that you always need to create new struct for each request, but since structs are very light-weight it shouldn't be a problem
    struct SearchAll: RouterRequest {
        var path: String { return "/search/person?api_key=\(apiKey)&language=en-US&page=1&include_adult=false" }
    }
    
    struct GetActorBasicInfo: RouterRequest {
        // Use for name, bio, birthday, place of birth, profile picture or gallery, movies apereance and roles
        let actorId: String
        
        var path: String { return "/person/\(actorId)?api_key=\(apiKey)&append_to_response=combined_credits&language=en-US&include_image_language=en,null" }
    }   
}
