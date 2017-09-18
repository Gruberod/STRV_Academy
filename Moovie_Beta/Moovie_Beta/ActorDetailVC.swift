//
//  ActorDetail.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit
import SwiftDate
import SwiftyImage
/*
class ImageViewWithFade: UIImageView {
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let backgroundCol = UIColor(colorLiteralRed: 19/255.0, green: 20/255.0, blue: 23/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        
        self.image = self.image.alpha(0.6)
        gradient.frame = self.frame
        gradient.colors = [UIColor.clear.cgColor, backgroundCol.cgColor]
        gradient.locations = [0.5, 1.0]
        self.layer.insertSublayer(gradient, at: 0)
    }
}
*/
class ActorDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var actorTable: UITableView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorPicture: UIImageView!
    @IBOutlet weak var gradient: UIImageView!
    @IBOutlet weak var cancelButton: UIButton?

    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    var viewModel: ActorDetailViewModel!
    var currentActor: Actor!
    var buttonHidden: Bool! = true
    
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
        
        cancelButton?.isHidden = buttonHidden
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        actorTable.rowHeight = UITableViewAutomaticDimension
        actorTable.estimatedRowHeight = 45
        actorTable.tableFooterView = UIView()
    }

}

extension ActorDetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let actingItemsCount = viewModel.actor?.acting?.count ?? 0
        
        return 6+actingItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescription") as! MovieDescriptionViewCell
            cell.movieDescription.text = viewModel.actor?.bio
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "BIRTHDAY"
            cell.additionalInfoText.text = viewModel.actor?.birthday
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "additionalDetail") as! AdditionalDetailInfo
            cell.additionalInfoTitle.text = "PLACE OF BIRTH"
            cell.additionalInfoText.text = viewModel.actor?.placeOfBirth
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Known for"
            cell.showAll.setTitle("", for: .normal)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
            viewModel.createDataForCarousel(input: viewModel.actor?.knownFor)
            cell.movies = viewModel.carouselData
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselHeaderOneliner") as! carouselHeaderOnelinerTableViewCell
            cell.title.text = "Acting"
            cell.showAll.setTitle("", for: .normal)
            return cell
        default:
            let movieYear = viewModel.actor?.acting?[indexPath.row-6].airYear
            let cell = tableView.dequeueReusableCell(withIdentifier: "actorActing") as! ActorActingTableViewCell
            var actingRole: String?
            if let character = viewModel.actor?.acting?[indexPath.row-6].character {
                actingRole = "as \(character)"
            }
            
            cell.actorActingYear.text = movieYear?.string(custom: "yyyy")
            cell.actorActingFilm.text = viewModel.actor?.acting?[indexPath.row-6].movieTitle
            cell.actorActingRole.text = actingRole
            return cell

        }
    }
}

extension ActorDetailVC: ActorDetailViewModelDelegate {
    func viewModelItemsUpdated() {
        actorTable.reloadData()
        actorName.text = currentActor.name
        actorPicture.af_setImage(withURL: (currentActor.picture)!)
        gradient.image = UIImage.size(width: 375, height: 333).color(gradient: [UIColor.clear, UIColor(colorLiteralRed: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.9)], locations: [0.5, 1.0], from: CGPoint(x: 1, y: 0), to: CGPoint(x: 1, y: 1)).image
    }
    
    func viewModelChangedState(state: ActorDetailViewModel.State) {
        print(state)
    }
}
