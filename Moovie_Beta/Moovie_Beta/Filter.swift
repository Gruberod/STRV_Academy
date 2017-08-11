////
////  Filter.swift
////  Moovie_Beta
////
////  Created by Gruberova, Daniela on 08/08/2017.
////  Copyright © 2017 Gruberova, Daniela. All rights reserved.
////

import UIKit

class Filter: UIViewController, UITableViewDataSource {

    @IBOutlet weak var filterOptions: UITableView!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    let options = ["All Generes", "Drama", "Fantasy", "Documentary", "Sci-Fi", "Action", "Horror", "Adventure"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        filterOptions.delegate = self
        filterOptions.dataSource = self
     
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
