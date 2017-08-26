//
//  GenreManager.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

class GenreManager {
    static var shared: GenreManager = {
        let manager = GenreManager(source: AlamofireGenreSource())
        manager.reload()
        return manager
    }()
    
    let source: GenreSource
    var genres: [Int:APIMovieGenre]?
    var loading: Bool = false
    
    static var defaultGenres: [Int:APIMovieGenre] = {
        return [:]
    }()
    
    init(source: GenreSource) {
        self.source = source
    }
    
    func reload() {
        if loading {
            return
        }
        loading = true
        
        source.fetchGenres() { result in
            if let genres = result.value {
                var genreMap = [Int:APIMovieGenre]()
                genres.forEach {
                    genreMap[$0.id] = $0
                }
                self.genres = genreMap
            }
            if let error = result.error {
                print(error)
            }
            self.loading = false
        }
    }
    
    func map(id: Int) -> APIMovieGenre? {
        if let genres = genres {
            return genres[id]
        } else {
            reload()
            return GenreManager.defaultGenres[id]
        }
    }
    
    func map(ids: [Int]) -> [APIMovieGenre] {
        return ids.flatMap { self.map(id: $0) }
    }
    
}
