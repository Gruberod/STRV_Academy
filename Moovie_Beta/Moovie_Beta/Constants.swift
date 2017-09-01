//
//  Constants.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 25/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation

struct Constants {
    static let apiKey = "c361d02c5dfff7d63adfafbb344088f9"
    static let apiLanguage = "en-US"
    static let apiImageLanguage = "en,null"
    static let apiRegion = "US"
    static let baseUrl = "https://api.themoviedb.org/3"
    static let imageBaseURL: URL = URL(string: "https://image.tmdb.org/t/p/")!
    
}

enum Sizes: String {
    case w92 = "w92"
    case w154 = "w154"
    case w185 = "w185"
    case w342 = "w342"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}
