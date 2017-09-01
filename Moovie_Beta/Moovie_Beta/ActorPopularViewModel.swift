//
//  ActorPopularViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 26/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol ActorListItem {
    var name: String { get }
    var picture: URL { get }
}

struct ActorPopularStub: ActorListItem {
    var name: String
    var picture: URL
}

protocol ActorPopularViewModelDelegate: class {
    func viewModelItemsUpdated(items: [ActorListItem])
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
    
    var items: [ActorListItem] = []
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
        if state == .loading {
            return
        }
        state = .loading
        
        self.actorSource.fetchPopular() { result in
            if let value = result.value {
                self.items = value.map {
                    ActorPopularStub(
                        name: $0.name,
                        picture: $0.url(size: .w185))
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
