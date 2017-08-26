//
//  ActorSource.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire
import UnboxedAlamofire
import Unbox


protocol ActorSource {
    
    func fetchActorDetail(id: Int, completion: @escaping (APIResult<APIActorFull>) -> Void)
}

class AlamofireActorSource: ActorSource {
    
    func fetchActorDetail(id: Int, completion: @escaping (APIResult<APIActorFull>) -> Void) {
        Alamofire.request(ActorRouter.Detail(actorId: id)).validate().responseObject() { (result:DataResponse<APIActorFull>) in
            completion(result.asAPIResult())
        }
    }
}
