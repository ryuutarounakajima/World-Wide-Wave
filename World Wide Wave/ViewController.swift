//
//  ViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/09/26.
//

import UIKit
import AuthenticationServices
import CoreData

class ViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    @IBOutlet weak var signUpImageView: UIImageView!
    
    @IBOutlet weak var signUpWithApple: UIButton!
    
    private let  imageLogo: UIImageView = {
        
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
        setUp()
        animateZoom()
        
        
    }
    
    @IBAction func SignUpWithAppleTapped(_ sender: Any) {
        performAppleSingnIn()
    }
    
    func setUp() {
        
        signUpImageView.layer.cornerRadius = 20
        signUpImageView.clipsToBounds = true
        signUpImageView.contentMode = .scaleAspectFill
    }
    
    //MARK: - Zoom Animation
    private func animateZoom() {
        
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
        view.addSubview(imageLogo)
        
        NSLayoutConstraint.activate([
            imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: 200),
            imageLogo.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        imageLogo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseOut],
                       animations: {
            self.imageLogo.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.imageLogo.alpha = 0.0
            
        }, completion: nil)
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 3.0
        fadeAnimation.fillMode = .forwards
        fadeAnimation.isRemovedOnCompletion = false
        
        gradientLayer.add(fadeAnimation, forKey: "fadeAnimation")
        
            
    }
    
    //MARK: - Apple Singn-IN function
    func performAppleSingnIn() {
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
    }
    

}

