//
//  SearchViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 06/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var searchResults: UITableView!
    
    var viewModel: MovieSearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults.delegate = self
        searchResults.dataSource = self
        
        searchResults.register(UINib(nibName: "searchItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
        
        viewModel = MovieSearchViewModel()
        viewModel.delegate = self as? MovieSearchViewModelDelegate
        viewModel.reloadMovies()

                // Do any additional setup after loading the view.
            }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? searchItemCellTableViewCell else {
                fatalError("Invalid cell class")
            }
            
            cell.nameMovieCell.text = viewModel.items[indexPath.row].name
//            cell.yearMovieCell.text = viewModel.items[indexPath.row].year
            cell.imageMovieCell.af_setImage(withURL: viewModel.items[indexPath.row].poster)
            cell.ratingMovieCell.image = #imageLiteral(resourceName: "rating")
            
            return cell
        }
    
        // here goes performe segue if clisked with item[indexPatr.row] parametre
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension SearchViewController: MovieSearchViewModelDelegate {
    func viewModelItemsUpdated(items: [MovieSearchListItem]) {
        searchResults.reloadData()
    }
    
    func viewModelChangedState(state: MovieSearchViewModel.State) {
        print(state)
    }
}
