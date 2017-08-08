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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let color = UIColor.darkGray
//        
//        myTextField.attributedPlaceholder = NSAttributedString(string: myTextField.placeholder!, attributes: [NSForegroundColorAttributeName : color])
//        
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
//        bottomLine.backgroundColor = UIColor.darkGray.cgColor
//        myTextField.borderStyle = UITextBorderStyle.none
//        myTextField.layer.addSublayer(bottomLine)
    }
    
    @IBOutlet weak var username: MyTextField!
    @IBOutlet weak var email: MyTextField!
    @IBOutlet weak var password: MyTextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        
//        // Change color of a placeholder text
//        let color = UIColor.darkGray
//        
//        username.attributedPlaceholder = NSAttributedString(string: username.placeholder!, attributes: [NSForegroundColorAttributeName : color])
//        
//        email.attributedPlaceholder = NSAttributedString(string: email.placeholder!, attributes: [NSForegroundColorAttributeName : color])
//        
//        password.attributedPlaceholder = NSAttributedString(string: password.placeholder!, attributes: [NSForegroundColorAttributeName : color])
//        
//        
//        // add a bottom liner to text field
//        let usernameBottomLine = CALayer()
//        usernameBottomLine.frame = CGRect(x: 0.0, y: username.frame.height - 1, width: username.frame.width, height: 1.0)
//        usernameBottomLine.backgroundColor = UIColor.darkGray.cgColor
//        username.borderStyle = UITextBorderStyle.none
//        username.layer.addSublayer(usernameBottomLine)
//        
//        let emailBottomLine = CALayer()
//        emailBottomLine.frame = CGRect(x: 0.0, y: email.frame.height - 1, width: email.frame.width, height: 1.0)
//        emailBottomLine.backgroundColor = UIColor.darkGray.cgColor
//        email.borderStyle = UITextBorderStyle.none
//        email.layer.addSublayer(emailBottomLine)
//        
//        let passwordBottomLine = CALayer()
//        passwordBottomLine.frame = CGRect(x: 0.0, y: password.frame.height - 1, width: password.frame.width, height: 1.0)
//        usernameBottomLine.backgroundColor = UIColor.darkGray.cgColor
//        password.borderStyle = UITextBorderStyle.none
//        password.layer.addSublayer(passwordBottomLine)
//    }

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
