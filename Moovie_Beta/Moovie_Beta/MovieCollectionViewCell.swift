//
//  MovieCollectionViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 07/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCellPicture: UIImageView!
    
    var movie: MovieStub? {
        didSet {
            movieCellPicture.af_setImage(withURL: (movie?.poster)!)
        }
    }
}
