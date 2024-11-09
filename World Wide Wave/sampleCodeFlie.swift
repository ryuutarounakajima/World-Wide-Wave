//
//  sampleCodeFlie.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/10/16.
//

import Foundation



/*
 

// ASAuthorizationControllerDelegate methods
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        // Save credentials in CoreData
        saveUserInCoreData(userID: userIdentifier, name: fullName?.givenName, email: email)
        
        // Handle successful login
        print("Login successful: \(userIdentifier), \(fullName?.givenName ?? ""), \(email ?? "")")
    }
}

func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error during Apple authentication
    print("Error during Apple sign-in: \(error.localizedDescription)")
}

// CoreData save function
func saveUserInCoreData(userID: String, name: String?, email: String?) {
    // Assuming Core Data setup with an entity "User" that has attributes "id", "name", and "email"
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
    let newUser = NSManagedObject(entity: entity, insertInto: context)
    
    newUser.setValue(userID, forKey: "id")
    newUser.setValue(name, forKey: "name")
    newUser.setValue(email, forKey: "email")
    
    do {
        try context.save()
        print("User saved to CoreData")
    } catch {
        print("Failed to save user: \(error)")
    }
}
}
 
 // checking if user logged in or not
 import UIKit
 import AuthenticationServices

 class SceneDelegate: UIResponder, UIWindowSceneDelegate {

     var window: UIWindow?

     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
 
 
 
         guard let windowScene = (scene as? UIWindowScene) else { return }

         let window = UIWindow(windowScene: windowScene)

         // ユーザーが既にログインしているかチェック
         if UserDefaults.standard.bool(forKey: "appoleAuthToken") {
             // ログイン済みの場合、メインタブバーを表示
             let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
             mainTabBarController.selectedIndex = 2  // 移動したいタブのインデックス

             window.rootViewController = mainTabBarController
         } else {
             // ログイン画面を表示
             let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
             window.rootViewController = loginViewController
         }

         self.window = window
         window.makeKeyAndVisible()
     }
 }
 
 //ASAuthorizationControllerDelegate methods
 
 func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
     
     if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
         
         let appleAuthToken = appleIDCredential.identityToken != nil ? String(data: appleIDCredential.identityToken!, encoding: .utf8) : "nilだよ~ん"
         UserDefaults.standard.set(appleAuthToken, forKey: "appleAuthToken")
         
         let userIdentifier = appleIDCredential.user
         let fullName = appleIDCredential.fullName
         let email = appleIDCredential.email
         
         let identifierString = userIdentifier.isEmpty ? "nilだよ~ん" : userIdentifier
         let givenName = fullName?.givenName ?? "nilだよ~ん"
         let emailString = email ?? "nilだよ~ん"
         
         print("Login successful: \(identifierString), \(givenName), \(emailString)")
         
         let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
         tabBarVC.tabBarController?.selectedIndex = 0
         
         self.view.window?.rootViewController = tabBarVC
         self.view.window?.makeKeyAndVisible()
     }
 }
*/
