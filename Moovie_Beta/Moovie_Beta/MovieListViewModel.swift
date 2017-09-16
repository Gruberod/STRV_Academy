//
//  MovieListViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import AlamofireImage
/*
protocol MovieListItem {
    var title: String { get }
    var id: Int { get }
    var genres: [String] { get }
    var description: String { get }
    var releaseDate: String? { get }
    var score: String { get }
    var poster: URL? { get }
}

struct MovieStub: MovieListItem {
    var title: String
    var id: Int
    var genres: [String]
    var description: String
    var releaseDate: String?
    var score: String
    var poster: URL?
}
*/
protocol MovieListViewModelDelegate: class {
    func viewModelItemsUpdated(items: [MovieFullItem])
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
    
    var popularItems: [MovieFull] = []
    var nowPlayingItems: [MovieFull] = []
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
                dateFormatter.dateStyle = .short
                
                self.nowPlayingItems = value.map {
                    MovieFull(
                        id: $0.id,
                        title: $0.title,
                        poster: $0.url(size: .w500),
                        score: $0.score,
                        overview: $0.overview,
                        releaseDate: $0.releaseDate,
                        genres: $0.genres,
                        creators: $0.filterCreators(),
                        actors: $0.actors,
                        videos: $0.videos,
                        images: $0.images,
                        reviews: $0.reviews
                    )
                }
                
                self.state = self.nowPlayingItems.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: (self.nowPlayingItems))
                
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
                dateFormatter.dateStyle = .short
                
                self.popularItems = value.map {
                    MovieFull(
                        id: $0.id,
                        title: $0.title,
                        poster: $0.url(size: .w500),
                        score: $0.score,
                        overview: $0.overview,
                        releaseDate: $0.releaseDate,
                        genres: $0.genres,
                        creators: $0.filterCreators(),
                        actors: $0.actors,
                        videos: $0.videos,
                        images: $0.images,
                        reviews: $0.reviews
                    )
                }

                self.state = self.popularItems.isEmpty ? .empty : .ready
                self.delegate?.viewModelItemsUpdated(items: (self.popularItems))
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
}
