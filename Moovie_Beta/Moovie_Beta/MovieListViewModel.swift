//
//  MovieListViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import AlamofireImage


// how to get full movie detail?

protocol MovieListItem {
    var title: String { get }
    var genres: [String] { get }
    var description: String { get }
    var releaseDate: String { get }
    var score: String { get }
    var poster: URL { get }
}

struct MovieStub: MovieListItem {
    var title: String
    var genres: [String]
    var description: String
    var releaseDate: String
    var score: String
    var poster: URL
}

protocol MovieListViewModelDelegate: class {
    func viewModelItemsUpdated(items: [MovieListItem])
    func viewModelChangedState(state: MovieListViewModel.State)
}

class MovieListViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let movieSource: MovieSource
    
    var items: [MovieListItem] = []
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    var error: Error?
    
    weak var delegate: MovieListViewModelDelegate?
    
    
    init(movieSource: MovieSource = AlamofireMovieSource()) {
        self.movieSource = movieSource
    }
    
    func reloadMovies() {
        if state == .loading {
            return
        }
        state = .loading
        
        self.movieSource.fetchNowPlaying() { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                self.items = value.map {
                    MovieStub(
                        title: $0.title,
                        genres: GenreManager.shared.map(ids: $0.genreIds).map { $0.name },
                        description: $0.overview,
                        releaseDate: "Release date: \(dateFormatter.string(from: $0.releaseDate))",
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
        
        self.movieSource.fetchMostPopular() { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                self.items = value.map {
                    MovieStub(
                        title: $0.title,
                        genres: GenreManager.shared.map(ids: $0.genreIds).map { $0.name },
                        description: $0.overview,
                        releaseDate: "Release date: \(dateFormatter.string(from: $0.releaseDate))",
                        score: $0.score == 0 ? "" : "\(Int($0.score*10)) %",
                        poster: $0.url(size: .w185))
                }
                print(value)
                self.state = self.items.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: self.items)
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
}
