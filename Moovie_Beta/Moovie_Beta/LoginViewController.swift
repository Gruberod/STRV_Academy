//
//  LoginViewController.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 05/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class MyTextFieldLogin: UITextField {
    
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

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var username: MyTextFieldLogin!
    @IBOutlet weak var password: MyTextFieldLogin!
    
    @IBAction func loginBtn(_ sender: UIButton) {
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

}
