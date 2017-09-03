//
//  SearchToggleViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class SearchToggleActorsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var searchActors: UITableView!
    
    var viewModel: ActorSearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            searchActors.delegate = self
            searchActors.dataSource = self
        
        searchActors.register(UINib(nibName: "actorItemCell", bundle: nil), forCellReuseIdentifier: "actorResultCell")
        
        viewModel = ActorSearchViewModel()
        viewModel.delegate = self as? ActorSearchViewModelDelegate
        viewModel.reloadActors()

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
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "actorResultCell", for: indexPath ) as? actorItemCell else {

            return UITableViewCell()
        
        }
        
        cell.actorPicture.af_setImage(withURL: viewModel.items[indexPath.row].picture)
        cell.actorName.text = viewModel.items[indexPath.row].name
        
        return cell
    }
    
    // here goes performe segue if clisked with item[indexPatr.row] parametre
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension SearchToggleActorsViewController: ActorSearchViewModelDelegate {
    func viewModelItemsUpdated(items: [ActorSearchListItem]) {
        searchActors.reloadData()
    }
    
    func viewModelChangedState(state: ActorSearchViewModel.State) {
        print(state)
    }
}
