//////
//////  OverviewViewController.swift
//////  Moovie_Beta
//////
//////  Created by Gruberova, Daniela on 04/08/2017.
//////  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//////

import UIKit
import SwiftCarousel

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var overviewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let sections: [String] = ["Section 1", "Section 2"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            // daredevil
            let cell = tableView.dequeueReusableCell(withIdentifier: "daredevil")!
            return cell
        } else if row == 1 || row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            return cell
        }
        
        fatalError("Not expected row")
    }
}

//class SwiftCarousel: UITableViewCell {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        items = ["Elephants", "Tigers", "Chickens", "Owls", "Rats", "Parrots", "Snakes"]
//        itemsViews = items!.map { labelForString($0) }
//        carousel.items = itemsViews!
//        carousel.resizeType = .VisibleItemsPerPage(3)
//        carousel.defaultSelectedIndex = 3 // Select default item at start
//        carousel.delegate = self
//    }
//    
//    func labelForString(string: String) -> UILabel {
//        let text = UILabel()
//        text.text = string
//        text.textColor = .black
//        text.textAlignment = .center
//        text.font = .systemFont(ofSize: 24.0)
//        text.numberOfLines = 0
//        
//        return text
//    }
//}
