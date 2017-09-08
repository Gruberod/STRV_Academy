//
//  MovieCarouselTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.


import UIKit

protocol CarouselDelegate: class {
    func didSelectMovie(movie: MovieListItem)
}

class MovieCarouselTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CarouselDelegate?
    
    var movies = [MovieListItem]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let pictureOnly = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(pictureOnly, forCellWithReuseIdentifier: "movieCell")
        
        let pictureWithTitle = UINib(nibName: "PictureWithTitleCollectionViewCell", bundle: nil)
        collectionView.register(pictureWithTitle, forCellWithReuseIdentifier: "pictureWithTitle")
        
    }

}

extension MovieCarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = movies[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        
        cell.movie = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 155, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        delegate?.didSelectMovie(movie: movie)
    }
    
}
