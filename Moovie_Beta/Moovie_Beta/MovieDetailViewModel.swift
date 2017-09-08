//
//  MovieDetailViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol MovieFullItem {
    var title: String { get }
    var description: String { get }
    var poster: URL? { get }
    var stars: String { get }
    var creators: String { get }
    var trailers: [String] { get }
    var reviews: [String] { get }
}

struct MovieFull: MovieFullItem {
    var title: String
    var description: String
    var poster: URL?
    var stars: String
    var creators: String
    var trailers: [String]
    var reviews: [String]
}

protocol MovieDetailViewModelDelegate: class {
    func viewModelItemsUpdated()
    func viewModelChangedState(state: MovieDetailViewModel.State)
}

class MovieDetailViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let movieSource: MovieSource
    var movie: MovieFull?
    
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    
    var error: Error?
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieSource: MovieSource = AlamofireMovieSource()) {
        self.movieSource = movieSource
    }
    

    func getMovieDetail(id: Int) {
        if state == .loading {
            return
        }
        state = .loading
        
        self.movieSource.fetchMovieDetail(id: id) { [weak self] result in
            
            guard let `self` = self else {
                return
            }
            
            if let value = result.value {
                self.movie = MovieFull(
                        title: value.title,
                        description: value.overview,
                        poster: value.url(size: .w185),
                        stars: value.filterActors(),
                        creators: value.filterCreators(),
                        trailers: [""],
                        reviews: [""])
//                      trailers: value.videos[indexPath.row],
//                      reviews: value.reviews[indexPath.row]
//                )
                
                self.state = .ready
                self.delegate?.viewModelChangedState(state: .ready)
                self.delegate?.viewModelItemsUpdated()
                
                } else {
                    self.error = result.error
                    self.state = .error
                }
            
            }
        }
    }
