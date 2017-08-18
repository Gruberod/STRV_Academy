//
//  Entities_Images.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox


// UnboxableByTransform allows you to specify certain type, that is unboxable without explicitly providing
// formatter. URLs are good example of this
struct ImageReference: UnboxableByTransform {
    // you just need to specify the type from which the transform takes place
    typealias UnboxRawValue = String
    
    let imagePath: String
    
    // implement this function to perform transformation. Here we are simply wrapping the string into ImageReference
    static func transform(unboxedValue: String) -> ImageReference? {
        return ImageReference(imagePath: unboxedValue)
    }
    
    static var baseImageURL: URL {
        return URL(string:"https://images.com")!
    }
    
    var fullURL: URL {
        return ImageReference.baseImageURL.appendingPathComponent("original").appendingPathComponent(imagePath)
    }
}
