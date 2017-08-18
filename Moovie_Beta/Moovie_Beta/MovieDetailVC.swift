//
//  MovieDetailVC.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 15/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var overviewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
    
        if row == 0 || row == 2 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
        return cell
    }
    
    fatalError("Not expected row")
}
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch (section) {
//        case 0:
//            return itemsA.count
//        case 1:
//            return itemsB.count
//        default:
//            return itemsC.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell") as! UITableViewCell
//        switch (indexPath.section) {
//        case 0:
//        //Access itemsA[indexPath.row]
//        case 1:
//        //Access itemsB[indexPath.row]
//        default:
//            //Access itemsC[indexPath.row]
//        }
//        return cell
//    }

}
