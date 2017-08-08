//////
//////  OverviewViewController.swift
//////  Moovie_Beta
//////
//////  Created by Gruberova, Daniela on 04/08/2017.
//////  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//////
//
//import UIKit
//
//class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var overviewTable: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        overviewTable.delegate = self
//        overviewTable.dataSource = self
//        
////        overviewTable.rowHeight = 20
//        
//        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
//        overviewTable.register(cellNib, forCellReuseIdentifier: "carouselCell")
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let row = indexPath.row
//        
//        if row == 0 {
//            // daredevil
//            let cell = tableView.dequeueReusableCell(withIdentifier: "daredevil")!
//            return cell
//        } else if row == 1 || row == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! MovieCarouselTableViewCell
//            return cell
//        }
//        
//        fatalError("Noy expected row")
//    }
//}
