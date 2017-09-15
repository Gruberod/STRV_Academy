//
//  ActorSource.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import UnboxedAlamofire
import Unbox


protocol ActorSource {
    
    func fetchActorDetail(id: Int, completion: @escaping (APIResult<APIActor>) -> Void)
    func fetchPopular(completion: @escaping (APIResult<[APIActor]>) -> Void)
    func searchActor(string: String, completion: @escaping (APIResult<[APIActor]>) -> Void)
}

class AlamofireActorSource: ActorSource {
    
    func fetchActorDetail(id: Int, completion: @escaping (APIResult<APIActor>) -> Void) {
        Alamofire.request(ActorRouter.Detail(actorId: id)).validate().responseObject() { (result:DataResponse<APIActor>) in
            completion(result.asAPIResult())
        }
    }
    
    func fetchPopular(completion: @escaping (APIResult<[APIActor]>) -> Void) {
        Alamofire.request(ActorRouter.Popular()).validate().responseObject() { (result:DataResponse<APIPopular>) in
            completion(result.asAPIResult() { $0.results} )
        }
    }

    func searchActor(string: String, completion: @escaping (APIResult<[APIActor]>) -> Void) {
        Alamofire.request(ActorRouter.Search(query: string)).validate().responseObject() { (result:DataResponse<APISearch>) in
            completion(result.asAPIResult() { $0.results} )
        }
    }
}
