//
//  CarouselTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.


import UIKit

protocol CarouselDelegate: class {
    func didSelectMovie(movie: MovieFullItem)
}

class CarouselTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CarouselDelegate?
    
    var movies = [MovieFull]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var stars = [APIMovieActor]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var hasSubtitles = false

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let pictureOnly = UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
        collectionView.register(pictureOnly, forCellWithReuseIdentifier: "carouselCollectionViewCell")
        
        let pictureWithTitle = UINib(nibName: "PictureWithTitleCollectionViewCell", bundle: nil)
        collectionView.register(pictureWithTitle, forCellWithReuseIdentifier: "pictureWithTitle")
        
    }

}

extension CarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hasSubtitles ? stars.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if hasSubtitles {
            let item = stars[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureWithTitle", for: indexPath) as? PictureWithTitleCollectionViewCell else {
                
                return UICollectionViewCell()
                
            }
            
            cell.star = item
            return cell
        } else {
        
            let item = movies[indexPath.row]
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell else {
            
                return UICollectionViewCell()
            
            }
        
            cell.movie = item
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return hasSubtitles ? CGSize(width: 155, height: 260) : CGSize(width: 155, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        delegate?.didSelectMovie(movie: movie)
    }
    
}
