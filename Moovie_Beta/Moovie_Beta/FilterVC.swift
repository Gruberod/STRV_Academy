////
////  Filter.swift
////  Moovie_Beta
////
////  Created by Gruberova, Daniela on 08/08/2017.
////  Copyright © 2017 Gruberova, Daniela. All rights reserved.
////

import UIKit

class FilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var filterOptions: UITableView!
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clear(_ sender: UIButton) {
        
    }
    
    let options = ["All Generes", "Drama", "Fantasy", "Documentary", "Sci-Fi", "Action", "Horror", "Adventure"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterOptions.dataSource = self
        filterOptions.delegate = self
        filterOptions.allowsSelection = true
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // prepsat na guard let
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filter_cell", for: indexPath) as! filterCellTableViewCell
        let text = options[row]
        cell.filterLabel.text = text
        
        return cell
    }
    
    
    // adding a tick to selected row
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? filterCellTableViewCell,
              indexPath.row < options.count else {
            return
        }

        selectedCell.accessoryType = selectedCell.accessoryType == .none ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
