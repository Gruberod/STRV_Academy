//
//  ActorDetail.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var actorTable: UITableView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorPicture: UIImageView!
    
    var viewModel: ActorDetailViewModel!
    var currentActor : Actor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorTable.delegate = self
        actorTable.dataSource = self

        viewModel = ActorDetailViewModel()
        viewModel.delegate = self
        viewModel.getActorDetail(id: currentActor.id)
        
        let cellNib = UINib(nibName: "CarouselTableViewCell", bundle: nil)
        actorTable.register(cellNib, forCellReuseIdentifier: "carouselTableViewCell")
        
        let movieDescription = UINib(nibName: "MovieDescriptionTableViewCell", bundle: nil)
        actorTable.register(movieDescription, forCellReuseIdentifier: "movieDescription")
        
        let additionalDetail = UINib(nibName: "AdditionalDetailInfo", bundle: nil)
        actorTable.register(additionalDetail, forCellReuseIdentifier: "additionalDetail")
        
        let carouselHeaderOneliner = UINib(nibName: "carouselHeaderOnelinerTableViewCell", bundle: nil)
        actorTable.register(carouselHeaderOneliner, forCellReuseIdentifier: "carouselHeaderOneliner")
        
        let actorActing = UINib(nibName: "ActorActingTableViewCell", bundle: nil)
        actorTable.register(actorActing, forCellReuseIdentifier: "actorActing")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        actorTable.rowHeight = UITableViewAutomaticDimension
        actorTable.estimatedRowHeight = 45
    }

}

extension ActorDetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case (0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.actor?.bio
            return cell
        case (1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "BIRTHDAY"
            cell.additionalInfoText.text = viewModel.actor?.birthday
            return cell
        case (2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "PLACE OF BIRTH"
            cell.additionalInfoText.text = viewModel.actor?.placeOfBirth
            return cell
        case (3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Known for"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (4):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
//            cell.movies = viewModel.actor!.knownFor
            
            return cell
        case (5):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Acting"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case (6):
//            let cell = tableView.dequeueReusableCell(withIdentifier: "actorActing") as! ActorActingTableViewCell
//            cell.data = viewModel.actor?.acting[indexPath.row]
//            return cell
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension ActorDetailVC: ActorDetailViewModelDelegate {
    func viewModelItemsUpdated() {
        actorTable.reloadData()
        actorName.text = currentActor.name
        actorPicture.af_setImage(withURL: (currentActor.picture)!)
    }
    
    func viewModelChangedState(state: ActorDetailViewModel.State) {
        print(state)
    }
}
