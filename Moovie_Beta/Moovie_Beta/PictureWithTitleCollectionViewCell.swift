//
//  PictureWithTitleCollectionViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 19/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class PictureWithTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageSubtitle: UILabel!
    
    var star: APIMovieActor? {
        didSet {
            guard let picture = star?.url(size: .w342) else {
                return
            }
            image.af_setImage(withURL: picture)
            imageTitle.text = star?.name
            imageSubtitle.text = star?.character
        }
    }

}
