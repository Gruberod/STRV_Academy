//
//  MovieCarouselTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.


import UIKit

class MovieCarouselTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rowheight: NSLayoutConstraint!
    
    var movies: APIMovieResults?
    var movie: APIMovieStub?
    
    var showWithLabel: Bool = false {
        didSet {
            rowheight.constant = showWithLabel ? 280 : 200
            self.layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pictureOnly = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(pictureOnly, forCellWithReuseIdentifier: "movieCell")
        
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if showWithLabel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureWithTitle", for: indexPath) as! PictureWithTitleCollectionViewCell
//            cell.image = movie.picture
            cell.imageTitle.text = movie?.title
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
//            cell.image = viewModel.movie.picture
            return cell
        }
    }
}
