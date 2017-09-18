//
//  SearchToggleViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchToggleActorsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var searchActors: UITableView!
    @IBOutlet weak var searchInput: UISearchBar!
    
    var viewModel: ActorSearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            searchActors.delegate = self
            searchActors.dataSource = self
        
        searchActors.register(UINib(nibName: "actorItemCell", bundle: nil), forCellReuseIdentifier: "actorResultCell")
        
        searchInput.delegate = self
        
        viewModel = ActorSearchViewModel()
        viewModel.delegate = self
        viewModel.reloadActors()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "actorResultCell", for: indexPath ) as? actorItemCell else {

            return UITableViewCell()
        }

        if let picture = viewModel.items[indexPath.row].picture {
//            let placeholderPic = UIImage(named: "placeholder")!
            cell.actorPicture.af_setImage(withURL: picture)
        }
        cell.actorName.text = viewModel.items[indexPath.row].name
        
        return cell
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchInput = searchBar.text ?? ""
        viewModel.reloadActors()
        searchBar.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" ,
            let nextScene = segue.destination as? ActorDetailVC,
            let indexPath = self.searchActors.indexPathForSelectedRow {
            let selectedActor = viewModel.items[indexPath.row]
            nextScene.currentActor = selectedActor
            nextScene.buttonHidden = false
        }
    }

}

extension SearchToggleActorsViewController: ActorSearchViewModelDelegate {
    func viewModelItemsUpdated(items: [Actor]) {
        searchActors.reloadData()
    }
    
    func viewModelChangedState(state: ActorSearchViewModel.State) {
        print(state)
    }
}
