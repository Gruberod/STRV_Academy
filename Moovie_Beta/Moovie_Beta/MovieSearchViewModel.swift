//
//  MovieSearchViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 28/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol MovieSearchViewModelDelegate: class {
    func viewModelItemsUpdated(items: [MovieFullItem])
    func viewModelChangedState(state: MovieSearchViewModel.State)
}

class MovieSearchViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let movieSource: MovieSource
    
    var searchInput = ""
    var items: [MovieFull] = []
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    var error: Error?
    
    weak var delegate: MovieSearchViewModelDelegate?
    
    
    init(movieSource: MovieSource = AlamofireMovieSource()) {
        self.movieSource = movieSource
    }
    
    func reloadMovies() {
        
        if state == .loading {
            return
        }
        state = .loading
        
        self.movieSource.searchMovie(string: searchInput) { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .short
                
                self.items = value.map {
                    MovieFull(
                        id: $0.id,
                        title: $0.title,
                        poster: $0.url(size: .w500),
                        score: $0.score,
                        overview: $0.overview,
                        releaseDate: dateFormatter.string(from: $0.releaseDate!),
                        genres: $0.genres,
                        creators: $0.filterCreators(),
                        actors: $0.actors,
                        videos: $0.videos,
                        reviews: $0.reviews
                    )
                }
                self.state = self.items.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: self.items)
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
}
