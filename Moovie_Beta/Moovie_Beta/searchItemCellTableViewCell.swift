//
//  searchItemCellTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 06/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class searchItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovieCell: UIImageView!
    @IBOutlet weak var nameMovieCell: UILabel!
    @IBOutlet weak var yearMovieCell: UILabel!
    @IBOutlet weak var ratingMovieCell: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
