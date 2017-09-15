//
//  SearchToggleViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

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
        
        cell.nameMovieCell.text = viewModel.items[indexPath.row].title
        cell.yearMovieCell.text = viewModel.items[indexPath.row].releaseDate
        cell.ratingMovieCell.text = viewModel.items[indexPath.row].score?.description
        
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" ,
            let nextScene = segue.destination as? MovieDetailVC ,
            let indexPath = self.searchToogle.indexPathForSelectedRow {
            let selectedMovie = viewModel.items[indexPath.row]
            nextScene.currentMovie = selectedMovie
            print(selectedMovie)
        }

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchInput = searchBar.text ?? ""
        viewModel.reloadMovies()
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
