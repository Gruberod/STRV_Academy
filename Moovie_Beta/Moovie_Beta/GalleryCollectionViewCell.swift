//
//  GalleryCollectionViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 07/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryPicture: UIImageView!
    
    var galleryItem: GalleryPictureItem? {
        didSet {
            galleryPicture.af_setImage(withURL: (galleryItem?.picture)!)
        }
    }
}
