//
//  ActorListViewModel.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

protocol ActorListItem {
    var name: String { get }
    var birthday: String { get }
    var placeOfBirth: String { get }
    var acting: [String] { get }
}

struct ActorStub {
    var name: String
    var birthday: String
    var placeOfBirth: String
    var acting: [String]
}

protocol ActorListViewModelDelegate: class {
    func viewModelItemsUpdated(items: [ActorListItem])
    func viewModelChangedState(state: ActorListViewModel.State)
}

class ActorListViewModel {
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
    
    weak var delegate: ActorListViewModelDelegate?
    
    init(actorSource: ActorSource = AlamofireActorSource()) {
        self.actorSource = actorSource
    }
    
//    func reloadActor(id: Int) {
//        if state == .loading {
//            return
//        }
//        state = .loading
//        
//        self.actorSource.fetchActorDetail(id: id) { result in
//            if let value = result.value {
//                let dateFormatter = DateFormatter()
//                dateFormatter.timeStyle = .none
//                dateFormatter.dateStyle = .medium
//                
//                self.item =
//                    ActorStub(
//                        name: $0.name,
//                        birthday: "\(dateFormatter.string(from: $0.releaseDate))",
//                        placeOfBirth: $0.placeOfBirth,
//                        acting: $0.acting
//                        
//                self.state = self.items.isEmpty ? .empty : .ready
//                self.delegate?.viewModelItemsUpdated(items: self.items)
//                
//            } else {
//                self.error = result.error
//                self.state = .error
//            }
//            
//        }
//    }
}
