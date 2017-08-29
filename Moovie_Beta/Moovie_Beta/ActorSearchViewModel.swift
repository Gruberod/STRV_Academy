//
//  ActorSearchViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 28/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol ActorSearchListItem {
    var name: String { get }
}

struct ActorSearchStub: ActorSearchListItem {
    var name: String
}

protocol ActorSearchViewModelDelegate: class {
    func viewModelItemsUpdated(items: [ActorSearchListItem])
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
    
    var items: [ActorSearchListItem] = []
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
        if state == .loading {
            return
        }
        state = .loading
        
//        self.actorSource.searchActor("jon Doe") { result in
//            if let value = result.value {
//                self.items = value.map {
//                    ActorSearchStub(
//                        name: $0.name)
//                }
//                self.state = self.items.isEmpty ? .empty : .ready
//                self.delegate?.viewModelItemsUpdated(items: self.items)
//                
//            } else {
//                self.error = result.error
//                self.state = .error
//            }
//        }
    }
}
