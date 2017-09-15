//
//  ActorsOverview.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorsOverviewVC: UIViewController {

    @IBOutlet weak var actorCOllectionView: UICollectionView!
    
    var viewModel: ActorPopularViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ActorPopularViewModel()
        viewModel.delegate = self
        viewModelChangedState(state: viewModel.state)
        
        viewModel.reloadActors()
        
        let itemWithTitle = UINib(nibName: "PictureWithTitleCollectionViewCell", bundle: nil)
        actorCOllectionView.register(itemWithTitle, forCellWithReuseIdentifier: "pictureWithTitle")
        
        
        //    let refreshControl = UIRefreshControl()
        //    refreshControl.addTarget(self, action: #selector(ActorsOverview.reloadAction), for: .valueChanged)
        //
        //    tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


extension ActorsOverviewVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureWithTitle", for: indexPath) as? PictureWithTitleCollectionViewCell else {
            fatalError("Invalid cell class")
        }
        if let picture = viewModel.items[indexPath.row].picture {
        cell.image.af_setImage(withURL: picture)}
        cell.imageTitle.text = viewModel.items[indexPath.row].name
        cell.imageSubtitle.text = viewModel.items[indexPath.row].popularKnownFor

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" ,
            let nextScene = segue.destination as? ActorDetailVC ,
            var indexPath = self.actorCOllectionView.indexPathsForSelectedItems?.first {
            let selectedActor = viewModel.items[indexPath.row]
            nextScene.currentActor = selectedActor 
        }
    }

}

extension ActorsOverviewVC: ActorPopularViewModelDelegate {
    func viewModelItemsUpdated(items: [Actor]) {
        actorCOllectionView.reloadData()
    }
    
    func viewModelChangedState(state: ActorPopularViewModel.State) {
        print(state)
    }
}
