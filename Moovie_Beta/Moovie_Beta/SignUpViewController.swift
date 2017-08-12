//
//  SignUpViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 05/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let color = UIColor.darkGray
        
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - 1, width: frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        borderStyle = UITextBorderStyle.none
        layer.addSublayer(bottomLine)
    }
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: MyTextField!
    @IBOutlet weak var email: MyTextField!
    @IBOutlet weak var password: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
