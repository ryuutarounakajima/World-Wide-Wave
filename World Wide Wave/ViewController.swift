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
    
    @IBAction func loginButton(_ sender: Any) {
        
        if isLoggedIn() {
            
            print("Already logged in")
            
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            tabBarVC.tabBarController?.selectedIndex = 0
            
            self.view.window?.rootViewController = tabBarVC
            self.view.window?.makeKeyAndVisible()
            
        } else {
            performAppleSingnIn()
        }
        
    }
    
    
    private func setUp() {
        
        signUpImageView.layer.cornerRadius = 20
        signUpImageView.clipsToBounds = true
        signUpImageView.contentMode = .scaleAspectFill

       
    }
    
    private func isLoggedIn() -> Bool {
        
        if let token = UserDefaults.standard.string(forKey: "appleAuthToken") {
            return !token.isEmpty
        }
        return false
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
        
        let authorizationContoller = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationContoller.delegate = self
        authorizationContoller.performRequests()
        
    }
    
    //MARK: - ASAuthorizationControllerDelegate methods
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let appleAuthToken = String(data:appleIDCredential.identityToken!, encoding: .utf8)
            
            UserDefaults.standard.set(appleAuthToken, forKey: "appleAuthToken")
            
            let useIdentifier = appleIDCredential.user
            
            let fullname = appleIDCredential.fullName
            
            let email = appleIDCredential.email
            
            
            print("Login successful: \(useIdentifier), \(fullname?.givenName ?? "no name"), \(email ?? "no address")")
            
          
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            tabBarVC.tabBarController?.selectedIndex = 0
            
            self.view.window?.rootViewController = tabBarVC
            self.view.window?.makeKeyAndVisible()
            
            
        }
        
    }
        
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        
        print("Error: \(error.localizedDescription)")
    }
    

}

