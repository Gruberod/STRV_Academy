//
//  SearchToggleViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import SwiftDate

class SearchToggleViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var searchToogle: UITableView!
    @IBOutlet weak var searchBarText: UISearchBar!
    
    var viewModel: MovieSearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
            searchToogle.delegate = self
            searchToogle.dataSource = self
        
        searchToogle.register(UINib(nibName: "searchItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
        
        searchBarText.delegate = self
        
        viewModel = MovieSearchViewModel()
        viewModel.delegate = self
        viewModel.reloadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath ) as? searchItemCellTableViewCell else {
            return UITableViewCell()
        }
        let movieYear = viewModel.items[indexPath.row].releaseDate
        var score: String?
        if let scoreValue = viewModel.items[indexPath.row].score {
            score = "\(Int(scoreValue*10)) %"
        }
        
        cell.nameMovieCell.text = viewModel.items[indexPath.row].title
        cell.yearMovieCell.text = movieYear?.string(custom: "yyyy")
        cell.ratingMovieCell.text = score
        
        if let poster = viewModel.items[indexPath.row].poster {
            cell.imageMovieCell.af_setImage(withURL: poster)
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" ,
            let nextScene = segue.destination as? MovieDetailVC ,
            let indexPath = self.searchToogle.indexPathForSelectedRow {
            let selectedMovie = viewModel.items[indexPath.row]
            nextScene.currentMovie = selectedMovie
            nextScene.buttonHidden = false
        }

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchInput = searchBar.text ?? ""
        viewModel.reloadMovies()
        searchBar.resignFirstResponder()
    }

}

extension SearchToggleViewController: MovieSearchViewModelDelegate {
    func viewModelItemsUpdated(items: [MovieFullItem]) {
        searchToogle.reloadData()
    }
    
    func viewModelChangedState(state: MovieSearchViewModel.State) {
        print(state)
    }
}
