//
//  CarouselCollectionViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 07/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class CarouselCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var carouselCellPicture: UIImageView!
    
    var movie: MovieFullItem? {
        didSet {
            carouselCellPicture.af_setImage(withURL: (movie?.poster)!)
        }
    }
}
