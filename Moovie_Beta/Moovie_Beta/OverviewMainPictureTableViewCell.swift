//
//  OverviewMainPictureTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 01/09/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

protocol MovieDelegate: class {
    func didSelectMovie(movie: MovieFullItem)
}

class OverviewMainPictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainPicture: UIImageView!
    @IBOutlet weak var mainMovieLabel: UILabel!
    
    weak var delegate: MovieDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
