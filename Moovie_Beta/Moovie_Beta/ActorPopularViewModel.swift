//
//  ActorPopularViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 26/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol ActorPopularViewModelDelegate: class {
    func viewModelItemsUpdated(items: [Actor])
    func viewModelChangedState(state: ActorPopularViewModel.State)
}

class ActorPopularViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let actorSource: ActorSource
    
    var items: [Actor] = []
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    
    var error: Error?
    
    weak var delegate: ActorPopularViewModelDelegate?
    
    init(actorSource: ActorSource = AlamofireActorSource()) {
        self.actorSource = actorSource
    }
    
    func reloadActors() {
        
        self.actorSource.fetchPopular() { result in
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium

                self.items = value.map {
                    Actor(
                        name: $0.name,
                        id: $0.id,
                        picture: $0.url(size: .w500),
                        bio: $0.bio,
                        birthday: $0.birthday?.description,
                        placeOfBirth: $0.placeOfBirth,
                        knownFor: $0.knownFor,
                        popularKnownFor: $0.filterMoviesKnownFor(),
                        acting: $0.acting
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
