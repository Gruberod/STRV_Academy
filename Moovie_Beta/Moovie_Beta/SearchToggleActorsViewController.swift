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
    
    override func viewDidLoad() {
        super.viewDidLoad()
            searchActors.delegate = self
            searchActors.dataSource = self
        
        searchActors.register(UINib(nibName: "actorItemCell", bundle: nil), forCellReuseIdentifier: "actorResultCell")

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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "actorResultCell", for: indexPath ) as? actorItemCell else {

            return UITableViewCell()
        
        }
        cell.actorPicture.image = #imageLiteral(resourceName: "actor3")
        cell.actorName.text = "Johny Depp"
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
