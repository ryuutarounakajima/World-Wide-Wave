//
//  ViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let  imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WaveLogLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.blue.cgColor,
            UIColor.cyan.cgColor,
            UIColor.white.cgColor,
            UIColor.systemBrown.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        view.layer.addSublayer(gradientLayer)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        animateZoom()
    }
    
    private func animateZoom() {
        
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseOut],
                       animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.imageView.alpha = 0.0
            
        }, completion: nil)
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 3.0
        fadeAnimation.fillMode = .forwards
        fadeAnimation.isRemovedOnCompletion = false
        
        gradientLayer.add(fadeAnimation, forKey: "fadeAnimation")
        
            
    }

}

