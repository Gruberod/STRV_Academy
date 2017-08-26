//
//  APIResults.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Alamofire


// why so many error handlers?


enum APIError: Error {
    case invalidJson(Any)
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        } else {
            return nil
        }
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        } else {
            return nil
        }
    }
}

// when result is an array?

extension DataResponse {
    
    func asAPIResult() -> APIResult<Value> {
        return asAPIResult() { $0 }
    }
    
    func asAPIResult<T>(mapBlock: (Value) -> T) -> APIResult<T> {
        switch self.result {
        case .success(let v):
            return .success(mapBlock(v))
        case .failure(let e):
            return .failure(e)
        }
    }
}
