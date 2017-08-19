//
//  MovieCarouselTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.


import UIKit

class MovieCarouselTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var showWithLabel = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let movieNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(movieNib, forCellWithReuseIdentifier: "movieCell")
        
        let pictureWithTitle = UINib(nibName: "PictureWithTitleCollectionViewCell", bundle: nil)
        collectionView.register(pictureWithTitle, forCellWithReuseIdentifier: "pictureWithTitle")
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if showWithLabel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureWithTitle", for: indexPath) as! PictureWithTitleCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: showWithLabel ? 250 : 180)
    }
}
