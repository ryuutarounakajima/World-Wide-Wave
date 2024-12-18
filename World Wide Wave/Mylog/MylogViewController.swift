//
//  ProfileViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/10/22.
//

import UIKit
import SwiftUI
import AuthenticationServices

class MylogViewController: UIViewController {
    
   
    @IBOutlet weak var logoutBuuton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swiftUIView = MylogSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    

    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "appleAuthToken")
        UserDefaults.standard.removeObject(forKey: "useremail")
        UserDefaults.standard.synchronize()
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
            
            print("logout success")
        }
    }
    
    
 
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
