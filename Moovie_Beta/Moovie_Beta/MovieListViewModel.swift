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
    var id: Int { get }
    var genres: [String] { get }
    var description: String { get }
    var releaseDate: String { get }
    var score: String { get }
    var poster: URL { get }
}

struct MovieStub: MovieListItem {
    var title: String
    var id: Int
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
    
    var popularItems: [MovieListItem] = []
    var nowPlayingItems: [MovieListItem] = []
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
    
    func reloadNowPlayingMovies() {
        
        self.movieSource.fetchNowPlaying() { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                print ("Now playing \(result)")
                
                self.nowPlayingItems = value.map {
                    MovieStub(
                        title: $0.title,
                        id: $0.id,
                        genres: GenreManager.shared.map(ids: $0.genreIds).map { $0.name },
                        description: $0.overview,
                        releaseDate: "Release date: \(dateFormatter.string(from: $0.releaseDate))",
                        score: $0.score == 0 ? "" : "\(Int($0.score*10)) %",
                        poster: $0.url(size: .w185))
                }
                self.state = self.nowPlayingItems.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: self.nowPlayingItems)
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
    
    func reloadMostPopularMovies() {
    
        self.movieSource.fetchMostPopular() { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                print ("Most popular \(result)")
                
                self.popularItems = value.map {

                    MovieStub(
                        title: $0.title,
                        id: $0.id,
                        genres: GenreManager.shared.map(ids: $0.genreIds).map { $0.name },
                        description: $0.overview,
                        releaseDate: "Release date: \(dateFormatter.string(from: $0.releaseDate))",
                        score: $0.score == 0 ? "" : "\(Int($0.score*10)) %",
                        poster: $0.url(size: .w185))
                }
                print(value)
                self.state = self.popularItems.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: self.popularItems)
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
}
