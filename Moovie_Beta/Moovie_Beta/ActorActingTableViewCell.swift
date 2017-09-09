////
////  ActorActingTableViewCell.swift
////  Moovie_Beta
////
////  Created by Gruberova, Daniela on 09/09/2017.
////  Copyright © 2017 Gruberova, Daniela. All rights reserved.
////
//
//import UIKit
//
//class ActorActingTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var actingYear: UILabel!
//    @IBOutlet weak var actingFilmAndRole: UILabel!
//    
//    var data = APIActorActing.self
//    
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
//    
//}
//
//extension ActorActingTableViewCell: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let item = data[indexPath.row]
//        
//        actingYear.text = item.airYear
//        actingFilmAndRole.text = "\(item.originalName) \(item.character)"
//        
//        return cell
//    }
//    
//}
