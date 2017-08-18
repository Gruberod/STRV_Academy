//
//  ActorDetail.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 08/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import UIKit

class ActorDetailVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.hidesBackButton = true
    }
}

extension UIView {
    
//    func layerGradient(colors c:[CGColor])->CAGradientLayer {
//        self.layer.sublayers = self.layer.sublayers?.filter(){!($0 is CAGradientLayer)}
//        let layer : CAGradientLayer = CAGradientLayer()
//        layer.frame.size = self.frame.size
//        layer.frame.origin = CGPoint.zero
//        layer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
//        self.layer.insertSublayer(layer, at: 0)
//        return layer
//    }
    
}
