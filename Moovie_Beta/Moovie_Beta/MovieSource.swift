//
//  MovieSource.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire
import UnboxedAlamofire
import Unbox


protocol MovieSource {
    
    func fetchMovieDetail(id: Int, completion: @escaping (APIResult<APIMovie>) -> Void)
    func fetchNowPlaying(completion: @escaping (APIResult<[APIMovie]>) -> Void)
    func fetchMostPopular(completion: @escaping (APIResult<[APIMovie]>) -> Void)
    func searchMovie(string: String, completion: @escaping (APIResult<[APIMovie]>) -> Void)
    
}

class AlamofireMovieSource: MovieSource {
    
    func fetchMovieDetail(id: Int, completion: @escaping (APIResult<APIMovie>) -> Void) {
        Alamofire.request(MovieRouter.Detail(movieId: id)).validate().responseObject() { (result:DataResponse<APIMovie>) in
            completion(result.asAPIResult())
        }
    }
    
    func fetchNowPlaying(completion: @escaping (APIResult<[APIMovie]>) -> Void) {
        Alamofire.request(MovieRouter.NowPlaying()).validate().responseObject() { (result:DataResponse<APIMovieResults>) in
            completion(result.asAPIResult() { $0.results } )
        }
    }
    
    func fetchMostPopular(completion: @escaping (APIResult<[APIMovie]>) -> Void) {
        Alamofire.request(MovieRouter.Popular()).validate().responseObject() { (result:DataResponse<APIMovieResults>) in
            completion(result.asAPIResult() { $0.results } )
        }
    }
    
    func searchMovie(string: String, completion: @escaping (APIResult<[APIMovie]>) -> Void) {
        Alamofire.request(MovieRouter.Search(query: string)).validate().responseObject() { (result:DataResponse<APIMSearch>) in
            completion(result.asAPIResult() { $0.results } )
        }
    }
    
}
