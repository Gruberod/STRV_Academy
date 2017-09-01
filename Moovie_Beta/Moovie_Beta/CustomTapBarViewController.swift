//
//  CustomTapBarViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 09/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class CustomTapBarViewController: UITabBarController {

    var blockSelection = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
}

extension CustomTapBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.tabBarItem?.badgeValue = nil
    }
}
