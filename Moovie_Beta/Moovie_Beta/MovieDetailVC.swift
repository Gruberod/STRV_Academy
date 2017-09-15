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
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerScore: UILabel!
    
    var viewModel: MovieDetailViewModel!
    var currentMovie: MovieFullItem!
    
//    var galleryItem: GalleryPictureItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTable.delegate = self
        overviewTable.dataSource = self
        
        let cellNib = UINib(nibName: "CarouselTableViewCell", bundle: nil)
        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselTableViewCell")
        
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
        
        let gallery = UINib(nibName: "GalleryTableViewCell", bundle: nil)
        overviewTable.register(gallery, forCellReuseIdentifier: "galleryCell")

        overviewTable.estimatedRowHeight = 155
        
        viewModel = MovieDetailViewModel()
        viewModel.delegate = self
        viewModel.getMovieDetail(id: currentMovie.id)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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
//            guard let (viewModel.movie?.reviews.count) != nil else {
//                return 0
//            }
//            return (viewModel.movie?.reviews.count)!
//        }
        return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.movie?.overview
            return cell
        case (0,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "CREATOR"
            cell.additionalInfoText.text = viewModel.movie?.creators
            return cell
        case (0,2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Stars"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (0,3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
//            cell.movies = viewModel.movie?.stars
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "galleryCell") as! GalleryTableViewCell
//            cell.pictures = viewModel.movie?.pictures as! [GalleryPictureItem]
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Reviews"
            cell.showAll.setTitle("SHOW ALL", for: .normal)
            return cell
        case (1,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "review") as! ReviewTableViewCell
            cell.reviewAuthor.text = viewModel.movie?.reviews?.first?.author
            cell.reviewText.text = viewModel.movie?.reviews?.first?.content
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
        headerImage.af_setImage(withURL: (currentMovie.poster)!)
        headerTitle.text = currentMovie.title
        headerScore.text = currentMovie.score?.description
    }
    
    func viewModelChangedState(state: MovieDetailViewModel.State) {
        print(state)
    }
}
