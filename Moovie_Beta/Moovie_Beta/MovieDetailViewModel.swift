//
//  MovieDetailViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol MovieFullItem {
    var id: Int { get }
    var title: String { get }
    var poster: URL? { get }
    var score: Float? { get }
    var overview: String? { get }
    var releaseDate: Date? { get }
    var genres: [APIMovieGenre]? { get }
    var creators: String? { get }
    var actors: [APIMovieActor]? { get }
    var videos: [APIMovieVideo]? { get }
    var images: [APIImages]? { get }
    var reviews: [APIMovieReviews]? { get }
}

struct MovieFull: MovieFullItem {
    var id: Int
    var title: String
    var poster: URL?
    var score: Float?
    var overview: String?
    var releaseDate: Date?
    var genres: [APIMovieGenre]?
    var creators: String?
    var actors: [APIMovieActor]?
    var videos: [APIMovieVideo]?
    var images: [APIImages]?
    var reviews: [APIMovieReviews]?
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
    
    var carouselData = [MovieFull]()
    
    func createDataForCarousel(input: [APIImages]?) {
        guard let input = input else {
            return
        }
        self.carouselData = input.map {
            MovieFull(id: 0,
                      title: "",
                      poster: $0.url(size: .w342),
                      score: nil,
                      overview: nil,
                      releaseDate: nil,
                      genres: nil,
                      creators: nil,
                      actors: nil,
                      videos: nil,
                      images: nil,
                      reviews: nil
            )
        }
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
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .short
                
                self.movie = MovieFull(
                        id: value.id,
                        title: value.title,
                        poster: value.url(size: .w500),
                        score: value.score,
                        overview: value.overview,
                        releaseDate: value.releaseDate,
                        genres: value.genres,
                        creators: value.filterCreators(),
                        actors: value.actors,
                        videos: value.videos,
                        images: value.images,
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
