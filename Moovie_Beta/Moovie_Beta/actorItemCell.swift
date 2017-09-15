//
//  actorItemCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 06/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class actorItemCell: UITableViewCell {

    @IBOutlet weak var actorPicture: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    var actor: APIActor? {
        didSet {
//            actorPicture.image = actor?.picture
            actorName.text = actor?.name
        }
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
