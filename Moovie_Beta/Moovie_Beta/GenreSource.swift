//
//  GenreSource.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire
import Unbox


protocol GenreSource {
    func fetchGenres(completion: @escaping (APIResult<[APIMovieGenre]>)->Void)
}

// there are several GenreSource implementations in order to demonstrate power of protocols and chaining to create new behavior
// WHY CACH?
class CachingGenreSource: GenreSource {
    let source: GenreSource
    
    var cache: [APIMovieGenre]?
    
    init(source: GenreSource) {
        self.source = source
    }
    
    func fetchGenres(completion: @escaping (APIResult<[APIMovieGenre]>) -> Void) {
        if let cache = cache {
            completion(.success(cache))
        }
        
        source.fetchGenres() { result in
            switch result {
            case .success(let data):
                self.cache = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class DefaultGenreSource: GenreSource {
    let source: GenreSource
    
    static var defaultGenres: [APIMovieGenre] {
        return []
    }
    
    init(source: GenreSource) {
        self.source = source
    }
    
    func fetchGenres(completion: @escaping (APIResult<[APIMovieGenre]>) -> Void) {
        source.fetchGenres() { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                completion(.success(DefaultGenreSource.defaultGenres))
            }
        }
    }
}


class AlamofireGenreSource: GenreSource {
    
    func fetchGenres(completion: @escaping (APIResult<[APIMovieGenre]>)->Void) {
        Alamofire.request(MovieRouter.Genres()).validate().responseJSON() { response in
            switch response.result {
            case .success(let dict as UnboxableDictionary):
                do {
                    try completion(.success(unbox(dictionary: dict, atKey: "genres")))
                } catch {
                    completion(.failure(error))
                }
            case .success(let dict):
                completion(.failure(APIError.invalidJson(dict)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
