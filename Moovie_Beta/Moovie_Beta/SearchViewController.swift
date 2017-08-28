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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                searchResults.delegate = self
                searchResults.dataSource = self
        
        searchResults.register(UINib(nibName: "searchItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")

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
                return 3
            }
        
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let row = indexPath.row
        
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as? searchItemCellTableViewCell
                    cell?.nameMovieCell.text = "Mars"
                    cell?.yearMovieCell.text = "2016"
                    cell?.imageMovieCell.image = nil
                    cell?.ratingMovieCell.image = #imageLiteral(resourceName: "rating")
                    return cell!
                } else if row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! searchItemCellTableViewCell
                    cell.nameMovieCell.text = "Deadpool"
                    cell.yearMovieCell.text = "2016"
                    cell.imageMovieCell.image = nil
                    cell.ratingMovieCell.image = #imageLiteral(resourceName: "rating")
                    return cell
                } else if row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! searchItemCellTableViewCell
                    cell.nameMovieCell.text = "Batman"
                    cell.yearMovieCell.text = "2014"
                    cell.imageMovieCell.image = nil
                    cell.ratingMovieCell.image = #imageLiteral(resourceName: "rating")
                    return cell
                }
                fatalError("Noy expected row")
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
