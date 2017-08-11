//
//  CustomTapBarViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 09/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class CustomTapBarViewController: UITabBarController {

    // you can adjust settings of this view controller via this property
    var blockSelection = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // manually set the delegate to self
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
}

// implementation of the tab bar controller delegate
extension CustomTapBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // this method is called when one of the tabs is selected
        print("UITabBarController: Selection changed - \(viewController.title ?? "")")
        
        // also clear badge number when selected
        viewController.tabBarItem?.badgeValue = nil
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // in this method you can decide if the tab user clicked on should be selected
        
        // here we simply forbid selection of viewcontroller with specific title if enabled
        return !blockSelection || viewController.title != "Unselectable"

    }
}
