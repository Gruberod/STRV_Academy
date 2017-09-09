//
//  MovieSearchViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 28/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol MovieSearchViewModelDelegate: class {
    func viewModelItemsUpdated(items: [MovieListItem])
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
    var items: [MovieListItem] = []
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
                self.items = value.map {
                    let separatedYear = ($0.releaseDate!).components(separatedBy: "-").first
                    
                    return MovieStub(
                        title: $0.title,
                        id: $0.id,
                        genres: GenreManager.shared.map(ids: $0.genreIds).map { $0.name },
                        description: $0.overview,
                        releaseDate: separatedYear,
                        score: $0.score == 0 ? "" : "\(Int($0.score*10)) %",
                        poster: $0.url(size: .w185))
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
