//
//  MovieSearchViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 28/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol MovieSearchListItem {
    var name: String { get }
}

struct MovieSearchStub: MovieSearchListItem {
    var name: String
}

protocol MovieSearchViewModelDelegate: class {
    func viewModelItemsUpdated(items: [MovieSearchListItem])
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
    
    var items: [MovieSearchListItem] = []
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
        
        // call is invalid failure(Alamofire.AFError.responseValidationFailed(Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(422) (Unproccessable entity))
        
        self.movieSource.searchMovie(string: "American Beauty") { result in
            print(result)
            if let value = result.value {
                self.items = value.map {
                    MovieSearchStub(
                        name: $0.name)
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
