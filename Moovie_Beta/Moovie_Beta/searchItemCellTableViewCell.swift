//
//  searchItemCellTableViewCell.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 06/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

struct cellData {
    let cell : Int!
    let name : String!
    let year : String!
    let image : UIImage!
    let rating : UIImage!
}
class searchItemCellTableViewCell: UITableViewCell {
    
    var arrayOfCellData = [cellData]()
    
    func viewDidLoad() {
        
        arrayOfCellData = [cellData(cell: 1, name: "Martian", year: "2017", image: #imageLiteral(resourceName: "image"), rating: #imageLiteral(resourceName: "rating")),
                           cellData(cell: 2, name: "Ghost in a shell", year: "2016", image: #imageLiteral(resourceName: "image"), rating: #imageLiteral(resourceName: "rating")),
                           cellData(cell: 3, name: "Despicable Me 3", year: "2015", image: #imageLiteral(resourceName: "image"), rating: #imageLiteral(resourceName: "rating")),
                           cellData(cell: 4, name: "Whatever other movie", year: "2017", image: #imageLiteral(resourceName: "image"), rating: #imageLiteral(resourceName: "rating"))]
    }

    @IBOutlet weak var imageMovieCell: UIImageView!
    @IBOutlet weak var nameMovieCell: UILabel!
    @IBOutlet weak var yearMovieCell: UILabel!
    @IBOutlet weak var ratingMovieCell: UIImageView!
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayOfCellData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if arrayOfCellData[indexPath.row].cell == 1 {
//            
//            let cell = Bundle.main.loadNibNamed("SearchItemCell", owner: self, options: nil)?.first as! searchItemCellTableViewCell
//            
//            cell.imageMovieCell.image = arrayOfCellData[indexPath.row].image
//            cell.nameMovieCell.text = arrayOfCellData[indexPath.row].name
//            cell.yearMovieCell.text = arrayOfCellData[indexPath.row].year
//            cell.ratingMovieCell.image = arrayOfCellData[indexPath.row].rating
//            
//            return cell
//            
//        } else if arrayOfCellData[indexPath.row].cell == 2 {
//            
//            let cell = Bundle.main.loadNibNamed("SearchItemCell", owner: self, options: nil)?.first as! searchItemCellTableViewCell
//            
//            cell.imageMovieCell.image = arrayOfCellData[indexPath.row].image
//            cell.nameMovieCell.text = arrayOfCellData[indexPath.row].name
//            cell.yearMovieCell.text = arrayOfCellData[indexPath.row].year
//            cell.ratingMovieCell.image = arrayOfCellData[indexPath.row].rating
//            
//            return cell
//        
//        
//        } else if arrayOfCellData[indexPath.row].cell == 3 {
//            
//            let cell = Bundle.main.loadNibNamed("SearchItemCell", owner: self, options: nil)?.first as! searchItemCellTableViewCell
//            
//            cell.imageMovieCell.image = arrayOfCellData[indexPath.row].image
//            cell.nameMovieCell.text = arrayOfCellData[indexPath.row].name
//            cell.yearMovieCell.text = arrayOfCellData[indexPath.row].year
//            cell.ratingMovieCell.image = arrayOfCellData[indexPath.row].rating
//            
//            return cell
//        
//        } else {
//            
//            let cell = Bundle.main.loadNibNamed("SearchItemCell", owner: self, options: nil)?.first as! searchItemCellTableViewCell
//            
//            cell.imageMovieCell.image = arrayOfCellData[indexPath.row].image
//            cell.nameMovieCell.text = arrayOfCellData[indexPath.row].name
//            cell.yearMovieCell.text = arrayOfCellData[indexPath.row].year
//            cell.ratingMovieCell.image = arrayOfCellData[indexPath.row].rating
//            
//            return cell
//        }
//        
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    }

