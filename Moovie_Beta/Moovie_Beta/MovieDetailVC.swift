//
//  MovieDetailVC.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 15/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var overviewTable: UITableView!
    @IBOutlet weak var movieName: UILabel!
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
        
        let movieDescription = UINib(nibName: "MovieDescriptionTableViewCell", bundle: nil)
        overviewTable.register(movieDescription, forCellReuseIdentifier: "movieDescription")
        
        let additionalDetail = UINib(nibName: "AdditionalDetailInfo", bundle: nil)
        overviewTable.register(additionalDetail, forCellReuseIdentifier: "additionalDetail")
        
        let carouselHeaderOneliner = UINib(nibName: "carouselHeaderOnelinerTableViewCell", bundle: nil)
        overviewTable.register(carouselHeaderOneliner, forCellReuseIdentifier: "carouselHeaderOneliner")
        
        let video = UINib(nibName: "VideoTableViewCell", bundle: nil)
        overviewTable.register(video, forCellReuseIdentifier: "video")
        
        let review = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        overviewTable.register(review, forCellReuseIdentifier: "review")
        // Do any additional setup after loading the view.
        
        overviewTable.rowHeight = UITableViewAutomaticDimension
        overviewTable.estimatedRowHeight = 45
        
        viewModel = MovieDetailViewModel()
        viewModel.delegate = self
        viewModel.getMovieDetail(id: 98)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        movieName.text = viewModel.movie?.title
    }
}

extension MovieDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.movie?.description
            return cell
        case (0,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "CREATOR"
            cell.additionalInfoText.text = "Drew Goddard, Steven S. DeKnight"
            return cell
        case (0,2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Stars"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            cell.showWithLabel = true
            return cell
        case (0,4):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Trailers"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,5):
            let cell = tableView.dequeueReusableCell(withIdentifier: "video") as! VideoTableViewCell
            return cell
        case (0,6):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Gallery"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,7):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Reviews"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (1,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "review") as! ReviewTableViewCell
            cell.reviewTitle.text = "Great show!"
            cell.reviewAuthor.text = "pusinka"
            cell.reviewText.text = "Didn't really have any expectations for Daredevil. After watching the movie as a kid and not overly enjoying it, I think Marvel has done an amazing job now that they have Daredevil back in their control."
            return cell
        default:
            return UITableViewCell()
        }
    }
}


extension MovieDetailVC: MovieDetailViewModelDelegate {
    func viewModelItemsUpdated() {
        overviewTable.reloadData()
        movieName.text = viewModel.movie?.title
    }
    
    func viewModelChangedState(state: MovieDetailViewModel.State) {
        print(state)
    }
}
