//
//  ProfileViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 11/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func options(_ sender: Any) {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        ac.addAction(UIAlertAction(title:"Log out", style: UIAlertActionStyle.destructive, handler: { (action) in
            ac.dismiss(animated: true, completion: nil)
        }))
        ac.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            ac.dismiss(animated: true, completion: nil)
        }))
        
        
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.delegate = self
        profileTable.dataSource = self
        
        let cellNib = UINib(nibName: "MovieCarouselTableViewCell", bundle: nil)
        profileTable.register(cellNib, forCellReuseIdentifier: "carouselCell")

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "carouselCell", for: indexPath ) as? MovieCarouselTableViewCell else {
            
            return UITableViewCell()
            
        }
        return cell
    }
    
//    func createAllert (option1: String, option2:String)
//    {
//        let alert = UIAlertController(title: option1, message: option2, preferredStyle: UIAlertControllerStyle.actionSheet)
//        
//        alert.addAction(UIAlertAction(title:"Logout", style: UIAlertActionStyle.default, handler: { (action) in
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
