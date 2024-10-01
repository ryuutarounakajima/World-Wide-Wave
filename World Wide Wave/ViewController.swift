//
//  ViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.blue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    }


}

