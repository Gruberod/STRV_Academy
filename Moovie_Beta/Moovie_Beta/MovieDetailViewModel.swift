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
    var stars: [APIMovieActor] { get }
    var creators: String { get }
//    var pictures: [APIPictureGallery] { get }
    var trailers: [APIMovieVideo] { get }
    var reviews: [APIMovieReviews] { get }
}

struct MovieFull: MovieFullItem {
    var title: String
    var description: String
    var poster: URL?
    var stars: [APIMovieActor]
    var creators: String
//    var pictures: [APIPictureGallery]
    var trailers: [APIMovieVideo]
    var reviews: [APIMovieReviews]
}

protocol GalleryPictureItem {
    var picture: URL? { get }
}

struct GalleryItem: GalleryPictureItem {
    var picture: URL?
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
                        poster: value.url(size: .w500),
                        stars: value.actors,
                        creators: value.filterCreators(),
//                        pictures: value.pictures,
                        trailers: value.videos,
                        reviews: value.reviews
                )
                
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
