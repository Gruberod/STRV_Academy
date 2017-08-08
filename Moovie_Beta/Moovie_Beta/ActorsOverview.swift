//
//  ActorsOverview.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorsOverview: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var actorCOllectionView: UICollectionView!
    var images = ["actor1", "actor2", "actor3", "actor4" ]
    
    func viewDidLoad() {
//        super.viewDidLoad()
        
        self.actorCOllectionView.delegate = self
        self.actorCOllectionView.dataSource = self
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actor_cell", for: indexPath) as! MyViewCellCollectionViewCell
        cell.actorCOllectionPicture.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    
}
