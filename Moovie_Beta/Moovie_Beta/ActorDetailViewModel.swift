//
//  ActorListViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol ActorItem {
    var name: String { get }
    var id: Int { get }
    var picture: URL? { get }
    var bio: String? { get }
    var birthday: String? { get }
    var placeOfBirth: String? { get }
    var knownFor: [APIActorKnownFor]? { get }
    var popularKnownFor: String? { get }
    var acting: [APIActorActing]? { get }

}

struct Actor {
    var name: String
    var id: Int
    var picture: URL?
    var bio: String?
    var birthday: String?
    var placeOfBirth: String?
    var knownFor: [APIActorKnownFor]?
    var popularKnownFor: String?
    var acting: [APIActorActing]?
}

protocol ActorDetailViewModelDelegate: class {
    func viewModelItemsUpdated()
    func viewModelChangedState(state: ActorDetailViewModel.State)
}

class ActorDetailViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let actorSource: ActorSource
    var actor: Actor?
    
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    
    var error: Error?
    
    weak var delegate: ActorDetailViewModelDelegate?
    
    init(actorSource: ActorSource = AlamofireActorSource()) {
        self.actorSource = actorSource
    }
    
    var carouselData = [MovieFull]()
    
    func createDataForCarousel(input: [APIActorKnownFor]?) {
        guard let input = input else {
            return
        }
        self.carouselData = input.map {
            MovieFull(id: $0.id,
                      title: $0.title ?? "",
                      poster: $0.url(size: .w185),
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
    
    func getActorDetail(id: Int) {
        
        self.actorSource.fetchActorDetail(id: id) { [weak self] result in
            
            guard let `self` = self else {
                return
            }
            
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                var birthday: String?
                if let birthdayDate = value.birthday {
                    birthday = dateFormatter.string(from: birthdayDate)
                }
                
                self.actor = Actor(
                    name: value.name,
                    id: value.id,
                    picture: value.url(size: .w780),
                    bio: value.bio,
                    birthday: birthday,
                    placeOfBirth: value.placeOfBirth,
                    knownFor: value.knownFor,
                    popularKnownFor: value.filterMoviesKnownFor(),
                    acting: value.acting
                )
                self.state = .ready
                self.delegate?.viewModelItemsUpdated()
                
            } else {
                self.error = result.error
                self.state = .error
            }
        }
    }
}
