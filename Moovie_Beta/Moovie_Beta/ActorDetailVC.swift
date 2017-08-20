//
//  ActorDetail.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var actorTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actorTable.delegate = self
        actorTable.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        actorTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        
        let movieDescription = UINib(nibName: "MovieDescriptionTableViewCell", bundle: nil)
        actorTable.register(movieDescription, forCellReuseIdentifier: "movieDescription")
       
        let additionalDetail = UINib(nibName: "AdditionalDetailInfo", bundle: nil)
        actorTable.register(additionalDetail, forCellReuseIdentifier: "additionalDetail")
      
        let carouselHeaderOneliner = UINib(nibName: "carouselHeaderOnelinerTableViewCell", bundle: nil)
       actorTable.register(carouselHeaderOneliner, forCellReuseIdentifier: "carouselHeaderOneliner")
        
        actorTable.rowHeight = UITableViewAutomaticDimension
        actorTable.estimatedRowHeight = 45
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case (0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = "​Laura Jeanne Reese Witherspoon (born March 22, 1976), better known as Reese Witherspoon, is an American actress and film producer. Witherspoon landed her first feature role as the female lead in the movie The Man in the Moon in 1991."
            return cell
        case (1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "BIRTHDAY"
            cell.additionalInfoText.text = "1976-03-22"
            return cell
        case (2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "PLACE OF BIRTH"
            cell.additionalInfoText.text = "New Orleans, Louisiana, USA"
            return cell
        case (3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Known for"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (4):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            cell.showWithLabel = false
            return cell
        case (5):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Acting"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case (6):
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}


