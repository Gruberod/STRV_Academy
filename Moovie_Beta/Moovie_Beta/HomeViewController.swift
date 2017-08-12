//
//  HomeViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 04/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var MyButton: UIButton!
    
    @IBOutlet weak var MyButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyButton2.layer.borderWidth = 3
        MyButton2.layer.borderColor = UIColor.darkGray.cgColor

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
