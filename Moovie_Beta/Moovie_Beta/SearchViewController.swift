//
//  SearchViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 06/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchResults: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                searchResults.delegate = self
                searchResults.dataSource = self
        
        //        overviewTable.rowHeight = 20
        
        searchResults.register(UINib(nibName: "searchItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")

                // Do any additional setup after loading the view.
            }
        
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
        
        
            /*
            // MARK: - Navigation
        
            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destinationViewController.
                // Pass the selected object to the new view controller.
            }
            */
        
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
        
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 3
            }
        
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let row = indexPath.row
        
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as? searchItemCellTableViewCell
                    return cell!
                } else if row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! searchItemCellTableViewCell
                    return cell
                } else if row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! searchItemCellTableViewCell
                    return cell
                }
                fatalError("Noy expected row")
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


