//
//  CustomNavBarViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 11/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class CustomNavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
