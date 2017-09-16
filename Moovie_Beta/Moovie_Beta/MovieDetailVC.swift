//
//  MovieDetailVC.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 15/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import AlamofireImage
import YouTubePlayer

class MovieDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var overviewTable: UITableView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var gradient: UIImageView!
    @IBOutlet weak var headerScore: UILabel!
    @IBOutlet weak var cancelButton: UIButton?
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var viewModel: MovieDetailViewModel!
    var currentMovie: MovieFullItem!
    var buttonHidden: Bool! = true
    
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
        
        cancelButton?.isHidden = buttonHidden
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

extension MovieDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let reviewItemsCount = viewModel.movie?.reviews?.count ?? 0
        return 7+reviewItemsCount

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.movie?.overview
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "CREATOR"
            cell.additionalInfoText.text = viewModel.movie?.creators
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Stars"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
            cell.hasSubtitles = true
            guard let stars = viewModel.movie?.actors else {
                return cell
            }
            cell.stars = stars
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Trailers"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "video") as! VideoTableViewCell
            guard let videoKey = viewModel.movie?.videos?.first?.key else {
                return cell
            }
            cell.video.loadVideoID(videoKey)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Gallery"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
            cell.hasSubtitles = false
            viewModel.createDataForCarousel(input: viewModel.movie?.images)
            cell.movies = viewModel.carouselData
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Reviews"
            cell.showAll.setTitle("", for: .normal)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "review") as! ReviewTableViewCell
            cell.reviewAuthor.text = viewModel.movie?.reviews?[indexPath.row-7].author
            cell.reviewText.text = viewModel.movie?.reviews?[indexPath.row-7].content
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch(indexPath.section, indexPath.row) {
            
        case (0,3):
            return 260
        case (0,5):
            return 250
        default:
            return UITableViewAutomaticDimension
        }
    }
}


extension MovieDetailVC: MovieDetailViewModelDelegate {
    func viewModelItemsUpdated() {
        overviewTable.reloadData()
        var score: String?
        guard let posterUrl = currentMovie.poster else {
            return
        }
        headerImage.af_setImage(withURL: posterUrl)
        gradient.image = UIImage.size(width: 375, height: 333).color(gradient: [UIColor.clear, UIColor(colorLiteralRed: 19/255.0, green: 20/255.0, blue: 23/255.0, alpha: 0.9)], locations: [0.5, 1.0], from: CGPoint(x: 1, y: 0), to: CGPoint(x: 1, y: 1)).image
        headerTitle.text = currentMovie.title
        if let scoreValue = currentMovie.score {
            score = "\(Int(scoreValue*10)) %"
        }
        headerScore.text = score
    }
    
    func viewModelChangedState(state: MovieDetailViewModel.State) {
        print(state)
    }
}
