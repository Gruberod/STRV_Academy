//
//  ProfileViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 11/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func options(_ sender: Any) {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        ac.addAction(UIAlertAction(title:"Log out", style: UIAlertActionStyle.destructive, handler: { (action) in
            ac.dismiss(animated: true, completion: nil)
        }))
        ac.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            ac.dismiss(animated: true, completion: nil)
        }))
        
        ac.view.tintColor = UIColor.black
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.rowHeight = 180
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        profileTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        
        let carouselHeaderOneliner = UINib(nibName: "carouselHeaderOnelinerTableViewCell", bundle: nil)
        profileTable.register(carouselHeaderOneliner, forCellReuseIdentifier: "carouselHeaderOneliner")

        profileTable.rowHeight = UITableViewAutomaticDimension
        profileTable.estimatedRowHeight = 45
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UILabel? {
//        let labelView: UILabel =  UILabel()
//        labelView.text = "hello"
//        return labelView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case (0):
        let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Favourite movies"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (1):
        let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
