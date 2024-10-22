//
//  ProfileViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/10/22.
//

import UIKit
import AuthenticationServices

class ProfileViewController: UIViewController {
    
   
    @IBOutlet weak var logoutBuuton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "userIdentifier")
        UserDefaults.standard.removeObject(forKey: "useremail")
        UserDefaults.standard.synchronize()
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
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
