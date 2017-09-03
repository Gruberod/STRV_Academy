//
//  MovieDetailVC.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 15/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var overviewTable: UITableView!
    
    var viewModel: MovieDetailViewModel!
    var currentMovie: MovieListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let moviePictureNib = UINib(nibName: "OverviewMainPictureTableViewCell", bundle: nil)
        overviewTable.register(moviePictureNib, forCellReuseIdentifier: "mainPicture")
        
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

        overviewTable.estimatedRowHeight = 155
        
        viewModel = MovieDetailViewModel()
        viewModel.delegate = self
        viewModel.getMovieDetail(id: currentMovie.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
}

extension MovieDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainPicture") as! OverviewMainPictureTableViewCell
            cell.mainPicture.af_setImage(withURL: currentMovie.poster)
            cell.mainMovieLabel.text = viewModel.movie?.title
            return cell
        case (0,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.movie?.description
            return cell
        case (0,2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "CREATOR"
            cell.additionalInfoText.text = "Drew Goddard, Steven S. DeKnight"
            return cell
        case (0,3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Stars"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,4):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
            return cell
        case (0,5):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Trailers"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,6):
            let cell = tableView.dequeueReusableCell(withIdentifier: "video") as! VideoTableViewCell
            return cell
        case (0,7):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Gallery"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,8):
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch(indexPath.section, indexPath.row) {
            
        case (0,0):
            return 200
        case (0,1):
            return UITableViewAutomaticDimension
        case (0,2):
            return 90
        case (0,3):
            return 50
        case (0,4):
            return 280
        case (0,5):
            return 50
        case (0,6):
            return 200
        case (0,7):
            return 50
        case (0,8):
            return 200
        case (1,0):
            return 50
        case (1,1):
            return UITableViewAutomaticDimension
            
        default:
            return UITableViewAutomaticDimension
        }
    }
}


extension MovieDetailVC: MovieDetailViewModelDelegate {
    func viewModelItemsUpdated() {
        overviewTable.reloadData()
    }
    
    func viewModelChangedState(state: MovieDetailViewModel.State) {
        print(state)
    }
}
