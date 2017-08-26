//
//  ActorsOverview.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorsOverviewVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var actorCOllectionView: UICollectionView!
   
    var images = ["actor1", "actor2", "actor3", "actor4", "actor1", "actor2", "actor3", "actor4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actorCOllectionView.delegate = self
        self.actorCOllectionView.dataSource = self
        
        let itemWithTitle = UINib(nibName: "PictureWithTitleCollectionViewCell", bundle: nil)
        actorCOllectionView.register(itemWithTitle, forCellWithReuseIdentifier: "pictureWithTitle")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureWithTitle", for: indexPath) as! PictureWithTitleCollectionViewCell
        cell.imageTitle.text = "Actor name"
        cell.imageSubtitle.text = "movies featured..."

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
