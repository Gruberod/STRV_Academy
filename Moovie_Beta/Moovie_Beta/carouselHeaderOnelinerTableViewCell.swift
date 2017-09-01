//
//  carouselHeaderOnelinerTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 19/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class carouselHeaderOnelinerTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var showAll: UIButton!
    @IBAction func showAll(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
