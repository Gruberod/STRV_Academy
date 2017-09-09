//
//  GalleryTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.


import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureGallery: UICollectionView!
    
    var pictures = [GalleryPictureItem]() {
        didSet {
            pictureGallery.reloadData()
        }
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let pictureOnly = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        pictureGallery.register(pictureOnly, forCellWithReuseIdentifier: "pictureCell")
    }

}

extension GalleryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = pictures[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? GalleryCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        
        cell.galleryItem = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 155, height: 198)
    }
    
}
