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
    
    func fetchMovieDetail(id: Int, completion: @escaping (APIResult<APIMovieFull>) -> Void)
    func fetchNowPlaying(completion: @escaping (APIResult<[APIMovieStub]>) -> Void)
    func fetchMostPopular(completion: @escaping (APIResult<[APIMovieStub]>) -> Void)
    
}

class AlamofireMovieSource: MovieSource {
    
    func fetchMovieDetail(id: Int, completion: @escaping (APIResult<APIMovieFull>) -> Void) {
        Alamofire.request(MovieRouter.Detail(movieId: id)).validate().responseObject() { (result:DataResponse<APIMovieFull>) in
            print(MovieRouter.Detail(movieId: 98).urlRequest)
            completion(result.asAPIResult())
        }
    }
    
    func fetchNowPlaying(completion: @escaping (APIResult<[APIMovieStub]>) -> Void) {
        Alamofire.request(MovieRouter.NowPlaying()).validate().responseObject() { (result:DataResponse<APIMovieResults>) in
            completion(result.asAPIResult() { $0.results } )
        }
    }
    
    func fetchMostPopular(completion: @escaping (APIResult<[APIMovieStub]>) -> Void) {
        Alamofire.request(MovieRouter.Popular()).validate().responseObject() { (result:DataResponse<APIMovieResults>) in
            completion(result.asAPIResult() { $0.results } )
        }
    }
    
}
