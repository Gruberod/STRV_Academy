//
//  OverviewViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet weak var overviewTable: UITableView!
    
    var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        
        let carouselTitleNib = UINib(nibName: "CarouselLabelTableViewCell", bundle: nil)
        overviewTable.register(carouselTitleNib, forCellReuseIdentifier: "carouselTitle")
        
        let mainMovieNib = UINib(nibName: "OverviewMainPictureTableViewCell", bundle: nil)
        overviewTable.register(mainMovieNib, forCellReuseIdentifier: "mainPicture")
        
        overviewTable.rowHeight = UITableViewAutomaticDimension
        overviewTable.estimatedRowHeight = 155
        
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(OverviewViewController.reloadAction), for: .valueChanged)
//        
//        tableView.refreshControl = refreshControl
//        
        viewModel = MovieListViewModel()
//        viewModel.delegate = self
//        viewModelChangedState(state: viewModel.state)

        viewModel.reloadMovies()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension OverviewViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    //TODO: Check if I can fill the collection view in table cell like this
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "mainPicture") as! OverviewMainPictureTableViewCell
            
            cell.mainPicture.image = #imageLiteral(resourceName: "image")
            cell.mainMovieLabel.text = "Placeholder"
            
            return cell
        } else if row == 2 || row == 4 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            
            // cell.movies = actor.movies
            
            // with this I can set the content of collection view here

            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
            cell.collectionView.delegate = self as? UICollectionViewDelegate
                
                return viewModel.items.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else {
                    fatalError("Invalid cell class")
                }
                cell.movieCellPicture.af_setImage(withURL: viewModel.items[indexPath.row].poster)
                
                return cell
            }

            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTitle") as! CarouselLabelTableViewCell
            cell.label.text = "Most popular"
            cell.button.setTitle("SHOW ALL", for: .normal)
            return cell
        } else if row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTitle") as! CarouselLabelTableViewCell
            cell.label.text = "Now playing"
            cell.button.setTitle("SHOW ALL", for: .normal)
            return cell
        }
        
        fatalError("Not expected row")
    }
    
    // tap to Movie detail - doesnt work
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}



//extension OverviewViewController: MovieListViewModelDelegate {
//    func viewModelItemsUpdated(items: [MovieListItem]) {
//        tableView.reloadData()
//    }
//    
//    func viewModelChangedState(state: MovieListViewModel.State) {
//        print(state)
//        
//        activityIndicator.isHidden = state != .loading
//        if !activityIndicator.isHidden {
//            activityIndicator.startAnimating()
//        }
//        
//        emptyOverlayView.isHidden = state != .empty
//        
//        if state != .loading {
//            tableView.refreshControl?.endRefreshing()
//        }
//    }
//}

