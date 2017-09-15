//
//  OverviewViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class OverviewViewController: UIViewController, CarouselDelegate {

    @IBOutlet weak var overviewTable: UITableView!
    
    var viewModel: MovieListViewModel!
    
    var movie: MovieFullItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let cellNib = UINib(nibName: "CarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselTableViewCell")
        
        let carouselTitleNib = UINib(nibName: "CarouselLabelTableViewCell", bundle: nil)
        overviewTable.register(carouselTitleNib, forCellReuseIdentifier: "carouselTitle")
        
        let mainMovieNib = UINib(nibName: "OverviewMainPictureTableViewCell", bundle: nil)
        overviewTable.register(mainMovieNib, forCellReuseIdentifier: "mainPicture")

        viewModel = MovieListViewModel()
        viewModel.delegate = self
        
        viewModel.reloadNowPlayingMovies()
        viewModel.reloadMostPopularMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        overviewTable.estimatedRowHeight = 155
    }
    
    func didSelectMovie(movie: MovieFullItem) {
        self.movie = movie
        
        performSegue(withIdentifier: "showDetail", sender: nil)

    }
    
}

extension OverviewViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.row) {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainPicture") as! OverviewMainPictureTableViewCell
            
            // If I try to load picture from viewmodel it crashes - delay?
            
            cell.mainPicture.image = #imageLiteral(resourceName: "image")
            cell.mainMovieLabel.text = viewModel.popularItems.first?.title
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTitle") as! CarouselLabelTableViewCell
            cell.label.text = "Most popular"
            cell.button.setTitle("SHOW ALL", for: .normal)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
            cell.movies = viewModel.popularItems
            cell.delegate = self
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTitle") as! CarouselLabelTableViewCell
            cell.label.text = "Now playing"
            cell.button.setTitle("SHOW ALL", for: .normal)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
            cell.movies = viewModel.nowPlayingItems
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch(indexPath.row) {
            
        case 0:
            return 250
        case 1:
            return 70
        case 2:
            return 200
        case 3:
            return 70
        case 4:
            return 200
            
        default:
            return UITableViewAutomaticDimension
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene = segue.destination as? MovieDetailVC
        nextScene?.currentMovie = movie
    }
}


extension OverviewViewController: MovieListViewModelDelegate {
    func viewModelItemsUpdated(items: [MovieFullItem]) {
        overviewTable.reloadData()
    }

    func viewModelChangedState(state: MovieListViewModel.State) {
        print(state)
    }
}

