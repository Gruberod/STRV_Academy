//
//  ActorSearchViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 28/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation


protocol ActorSearchViewModelDelegate: class {
    func viewModelItemsUpdated(items: [Actor])
    func viewModelChangedState(state: ActorSearchViewModel.State)
}

class ActorSearchViewModel {
    enum State {
        case empty
        case loading
        case ready
        case error
    }
    
    let actorSource: ActorSource
    
    var searchInput = ""
    var items: [Actor] = []
    var state: State = .empty {
        didSet {
            if state != oldValue {
                delegate?.viewModelChangedState(state: state)
            }
        }
    }
    var error: Error?
    
    weak var delegate: ActorSearchViewModelDelegate?
    
    
    init(actorSource: ActorSource = AlamofireActorSource()) {
        self.actorSource = actorSource
    }
    
    func reloadActors() {
        
        self.actorSource.searchActor(string: searchInput) { result in
            print(result)
            if let value = result.value {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                self.items = value.map {
                    Actor(
                        name: $0.name,
                        id: $0.id,
                        picture: $0.url(size: .w185),
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
